//
//  HomeStep2View.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 17.01.2022.
//

import SwiftUI

struct HomeStep2View: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: HomeStep2ViewModel
    
    var body: some View {
        ZStack {
            BackgroundGradientView()
            
            VStack {
                
                Spacer(minLength: 34)
                
                Button {
                    viewModel.leaderBoardButton()
                } label: {
                    ZStack {
                        Color.flIndigo
                        Text("SHOW LEADERBOARD")
                            .underline()
                            .font(.robotoCondensedBold(size: 26))
                            .foregroundColor(.flYellow)
                            .offset(y: -7)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 71)
                }
                .fullScreenCover(isPresented: $viewModel.showLeaderBoardView) {
                    LeaderboardView(viewModel: LeaderboardViewModel())
                }
            }
            .edgesIgnoringSafeArea(.top)
            .ignoresSafeArea(.all, edges: .bottom)
            
            VStack(spacing: 30) {
                Image("flovatar-logo")
                
                Button("PLAY MINI GAMES") {
                    viewModel.miniGamesButton()
                }
                .buttonStyle(Rectangle3DButtonStyle(btnColor: .flYellow))
                .frame(width: 280)
                
                ScoreView(text: "Total\nScore", score: viewModel.totalScore)
            }
            
            LogOutView(isShowed: $viewModel.showLogOutView) {
                viewModel.logout()
                dismiss()
            }
            .opacity(viewModel.showLogOutView ? 1 : 0)
            .animation(.easeOut(duration: 0.3), value: viewModel.showLogOutView)
            
            NavigationLink("PlayMiniGames", isActive: $viewModel.playMiniGamesView) {
                MiniGamesView(
                    viewModel: MiniGamesViewModel(scoreModels: viewModel.scoreModels)
                )
            }
            .hidden()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            leading: Button {
                dismiss()
            } label: {
                ZStack {
                    Image("home")
                        .resizable()
                        .renderingMode(.template)
                        .frame(width: 22, height: 22.5)
                        .offset(y: -2)
                        .foregroundColor(.white)
                }
                .frame(width: 44, height: 44)
                .background(Color.fuchsia)
                .clipShape(Circle())
                .padding(.leading, 15)
            }, trailing: Button {
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
        .onAppear(perform: viewModel.homeStep2ViewDidAppear)
    }
}

#if DEBUG
struct HomeStep2View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeStep2View(viewModel: HomeStep2ViewModel(scoreModels: nil))
        }
    }
}
#endif
