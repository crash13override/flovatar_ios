//
//  ChooseYourPlayerView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 30.12.2021.
//

import SwiftUI
import Shimmer

struct ChooseYourPlayerView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: ChooseYourPlayerViewModel
    
    @State var playGame: Bool = false
    @State var currentFlovatar: Flovatar?
    @State var activeTab: Int = 0
    
    var body: some View {
        ZStack {
            Color.flIndigo
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                title
                
                ZStack(alignment: .top) {
                    VStack(spacing: 0) {
                        ZStack(alignment: .bottom) {
                            
                            flovatarsCarousel
                            
                            Image("Beam2")
                                .resizable()
                                .shimmering()
                                .allowsHitTesting(false)
                        }
                        .frame(height: 310)
                        .padding(.horizontal, 24)
                        
                        nameView
                        
                        nfts
                        
                        footerButtons
                        
                    }
                    .onChange(of: viewModel.flovatars) { newValue in
                        currentFlovatar = newValue.first
                    }
                }
            }
            
            LoadingView()
                .opacity(viewModel.showLoadingFlovatarsView ? 1 : 0)
                .animation(.easeIn(duration: 0.3), value: viewModel.showLoadingFlovatarsView)
            
            NavigationLink(
                destination: playGameView,
                isActive: $playGame
            ) { EmptyView() }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading:
                Button {
                    dismiss()
                } label: {
                    ZStack {
                        Image("home")
                            .resizable()
                            .frame(width: 22, height: 22.5)
                            .offset(y: -2)
                    }
                    .frame(width: 44, height: 44)
                    .background(Color.fuchsia)
                    .clipShape(Circle())
                    .padding(.leading, 15)
                }
        )
        .onAppear {
            viewModel.fetchNFTs()
        }
    }
    
    @ViewBuilder
    private var title: some View {
        Text("CHOOSE YOUR PLAYER")
            .font(.staatlichesRegular(size: 40))
            .kerning(2)
            .foregroundColor(.white)
    }
    
    @ViewBuilder
    private var flovatarsCarousel: some View {
        if !viewModel.flovatars.isEmpty {
            TabView(selection: $activeTab) {
                ForEach(Array(viewModel.flovatars.enumerated()), id: \.offset) { index, flovatar in
                    if let svg = flovatar.svg, !svg.isEmpty {
                        WebView(image: svg)
                            .onTapGesture {
                                currentFlovatar = flovatar
                            }
                            .tag(index)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .onChange(of: activeTab, perform: { index in
                currentFlovatar = viewModel.flovatars[index]
            })
        }
    }
    
    @ViewBuilder
    private var nameView: some View {
        VStack(spacing: 10) {
            if let currentFlovatar = currentFlovatar, let name = currentFlovatar.name, !name.isEmpty {
                Text(name)
                    .foregroundColor(.white)
                    .font(.staatlichesRegular(size: 30))
            }
            
            Image("active")
                .resizable()
                .frame(width: 24, height: 12)
        }
        .padding(.top)
    }
    
    @ViewBuilder
    private var nfts: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { value in
                LazyHStack(spacing: -30) {
                    ForEach(Array(viewModel.flovatars.enumerated()), id: \.offset) { index, flovatar in
                        if let svg = flovatar.svg, !svg.isEmpty {
                            SVGImage(image: svg)
                                .frame(width: 128, height: 168)
                                .onTapGesture {
                                    currentFlovatar = flovatar
                                    activeTab = index
                                }
                                .onAppear {
                                    viewModel.current(index: index)
                                }
                                .id(index)
                        }
                    }
                    
                    if viewModel.isLoadingNextPage {
                        ZStack {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                                .scaleEffect(2)
                        }
                        .frame(width: 128, height: 168)
                    }
                }
                .onChange(of: activeTab, perform: { index in
                    withAnimation {
                        value.scrollTo(index, anchor: .center)
                    }
                })
            }
        }
        .frame(height: 168)
    }
    
    @ViewBuilder
    private var footerButtons: some View {
        HStack(spacing: 25) {
            Button("BACK") {
                dismiss()
            }
            .buttonStyle(Rectangle3DButtonStyle(
                textColor: .white,
                btnColor: .flIndigo)
            )
            .frame(width: 104)
            
            Button("PLAY") {
                playGame = true
            }
            .buttonStyle(Rectangle3DButtonStyle(btnColor: .flYellow))
            .frame(width: 104)
        }
    }
    
    @ViewBuilder
    private var playGameView: some View {
        if let game = viewModel.choosedGame {
            switch game {
            case .whereIsFlodo:
                WhereIsWaldoView(viewModel: WhereIsWaldoViewModel(flovatars: []))
            case .whachAFlovatar:
                WhackAFlovatarView(viewModel: WhackAFlovatarViewModel(flovatars: viewModel.flovatars))
            case .flovatarRunner:
                Text("flovatarRunner")
            }
        }
    }
}

#if DEBUG
struct ChooseYourPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChooseYourPlayerView(
                viewModel: ChooseYourPlayerViewModel(address: "", choosedGame: .whereIsFlodo)
            )
        }
    }
}
#endif
