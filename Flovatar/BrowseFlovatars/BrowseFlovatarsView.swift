//
//  BrowseFlovatarsView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 13.01.2022.
//

import SwiftUI
import Shimmer

struct BrowseFlovatarsView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: BrowseFlovatarsViewModel

    @State var currentFlovatar: Flovatar?
    @State var activeTab: Int = 0
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                VStack {
                    ZStack(alignment: .bottom) {
                        VStack {
                            Spacer()
                            
                            flovatarsCarousel
                        }
                        
                        Image("Beam")
                            .resizable()
                            .shimmering()
                            .allowsHitTesting(false)
                        
                    }
                    .frame(height: proxy.size.height / 3 * 2)
                    .padding(.top, -50)
                    
                    if let currentFlovatar = currentFlovatar {
                        boostersView(flovatar: currentFlovatar)
                            .frame(height: 60)
                    }
                    
                    if let currentFlovatar = currentFlovatar, let name = currentFlovatar.name, !name.isEmpty {
                        VStack {
                            Text(name)
                                .foregroundColor(.white)
                                .font(.staatlichesRegular(size: 30))
                                .padding()
                            
                            Image("active")
                                .resizable()
                                .frame(width: 24, height: 12)
                        }
                    }
                    
                    Spacer()
                    
                    nfts
                    
                }
                .background(
                    Color.flIndigo
                        .ignoresSafeArea()
                )
                .onChange(of: viewModel.flovatars) { newValue in
                    currentFlovatar = newValue.first
                }
                
                LoadingView()
                    .opacity(viewModel.showLoadingFlovatarsView ? 1 : 0)
                    .animation(.easeIn(duration: 0.3), value: viewModel.showLoadingFlovatarsView)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarItems(
            trailing: Button {
                dismiss()
                viewModel.flovatars.removeAll()
            } label: {
                Image(systemName: "multiply")
                    .resizable()
                    .frame(width: 23, height: 23)
                    .foregroundColor(.white)
                    .padding(.trailing, 20)
            }
        )
        .navigationBarBackButtonHidden(true)
        .onAppear {
            viewModel.fetchNFTs()
        }
    }
    
    @ViewBuilder private var nfts: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { value in
                LazyHStack(spacing: -30) {
                    ForEach(Array(viewModel.flovatars.enumerated()), id: \.offset) { index, flovatar in
                        if let svg = flovatar.svg, !svg.isEmpty {
                            SVGImage(image: svg)
                                .frame(width: 150, height: 200)
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
                    
                    if viewModel.showProgressView {
                        ZStack {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                                .scaleEffect(2)
                        }
                        .frame(width: 150, height: 200)
                    }
                }
                .onChange(of: activeTab, perform: { index in
                    withAnimation {
                        value.scrollTo(index, anchor: .center)
                    }
                })
            }
        }
    }
    
    @ViewBuilder private func boostersView(flovatar: Flovatar?) -> some View {
        HStack(spacing: 15) {
            if let flovatar = flovatar {
                BoosterView(imageName: "booster_1", name: "\(flovatar.rareCount)")
                BoosterView(imageName: "booster_2", name: "\(flovatar.legendaryCount)")
                BoosterView(imageName: "booster_3", name: "\(flovatar.epicCount)")
            } else {
                BoosterView(imageName: "booster_1", name: "0")
                BoosterView(imageName: "booster_2", name: "0")
                BoosterView(imageName: "booster_3", name: "0")
            }
        }
    }
    
    @ViewBuilder private var flovatarsCarousel: some View {
        if !viewModel.flovatars.isEmpty {
            TabView(selection: $activeTab) {
                ForEach(Array(viewModel.flovatars.enumerated()), id: \.offset) { index, flovatar in
                    if let svg = flovatar.svg, !svg.isEmpty {
                        WebView(image: svg)
                            .padding(.bottom, -50)
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
}
