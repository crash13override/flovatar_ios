//
//  HomeStep1View.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 19.01.2022.
//

import SwiftUI

struct HomeStep1View: View {
    
    @StateObject var viewModel = HomeStep1ViewModel()
    @EnvironmentObject private var navigationUtil: NavigationUtil
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            
            if viewModel.loginState.isLoggedIn {
                userInfoView
            }
            
            VStack(spacing: 20) {
                Image("flovatar-logo")
                    .padding(.bottom, 30)
                
                Button("PUBLIC FLOVATARS") {
                    viewModel.publicFlovatars()
                }
                .buttonStyle(Rectangle3DButtonStyle())
                
                Button("MY FLOVATARS") {
                    viewModel.myFlovatars()
                }
                .buttonStyle(Rectangle3DButtonStyle())
                
                Button("PLAY MINI GAMES") {
                    viewModel.miniGames()
                }
                .buttonStyle(Rectangle3DButtonStyle(btnColor: .flYellow))
                
                NavigationLink(
                    destination: BrowseFlovatarsView(
                        viewModel: BrowseFlovatarsViewModel(
                            address: viewModel.address)),
                    isActive: $viewModel.showFlovatarsView
                ) { EmptyView() }
                
                NavigationLink(
                    destination: HomeStep2View(
                        viewModel: HomeStep2ViewModel(scoreModels: viewModel.scoreModels)),
                    isActive: $viewModel.showMiniGamesView
                ) { EmptyView() }
            }
            .padding(.horizontal, 50)
            
            LogOutView(isShowed: $viewModel.showLogOutView, logOutAction: viewModel.logout)
                .opacity(viewModel.showLogOutView ? 1 : 0)
                .animation(.easeOut(duration: 0.3), value: viewModel.showLogOutView)
        }
        .navigationBarHidden(false)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing:
                Button {
                    viewModel.showLogOutView = true
                } label: {
                    Image("logoutIcon")
                        .resizable()
                        .frame(width: 44, height: 44)
                        .padding(.trailing, 15)
                }
                .opacity(viewModel.loginState.isLoggedIn ? 1 : 0)
                .disabled(!viewModel.loginState.isLoggedIn)
        )
        .onAppear(perform: viewModel.homeStep1ViewDidAppear)
        .onReceive(navigationUtil.$showRoot) { showRoot in
            if showRoot {
                viewModel.showMiniGamesView = false
            }
        }
    }
    
    private var userInfoView: some View {
        VStack {
            Spacer()
            
            HStack {
                
                Spacer()
                
                Text("Total Score: " + viewModel.totalScore)
                    .font(.robotoCondensedBold(size: 24))
                    .foregroundColor(.white)
                    .minimumScaleFactor(0.8)
                    .padding(.trailing, 10)
                    .lineLimit(1)
            }
            .frame(height: 72)
        }
        .padding(.horizontal, 35)
    }
}

#if DEBUG
struct HomeStep1View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeStep1View()
                .environmentObject(NavigationUtil())
        }
    }
}
#endif
