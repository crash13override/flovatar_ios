//
//  MiniGamesView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 17.01.2022.
//

import SwiftUI

struct MiniGamesView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: MiniGamesViewModel
    
    var body: some View {
        ZStack {
            Color.flIndigo
            
            footerView
            
            VStack {
                titleView
                
                VStack(spacing: 12) {
                    ForEach(viewModel.games, id: \.title) { game in
                        Button {
                            viewModel.choose(miniGame: game.game)
                        } label: {
                            MiniGameRowView(model: game)
                        }
                    }
                }
                .padding(.horizontal)
            }
            
            NavigationLink(
                destination: playGameView,
                isActive: $viewModel.gameDidChoose
            ) { EmptyView() }
        }
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing:
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "multiply")
                        .resizable()
                        .frame(width: 23, height: 23)
                        .foregroundColor(.white)
                        .padding(.trailing, 20)
                }
        )
        .onAppear(perform: viewModel.loadScore)
    }
    
    @ViewBuilder private var titleView: some View {
        if viewModel.loginState.isLoggedIn {
            Text("CHOOSE A GAME")
                .font(.staatlichesRegular(size: 40))
                .kerning(2)
                .foregroundColor(.white)
        } else {
            VStack(spacing: 10) {
                Text("MINI GAMES")
                    .font(.robotoCondensedBold(size: 40))
                    .kerning(2)
                
                Text("What do you want to play?")
                    .font(.robotoCondensedRegular(size: 28))
            }
            .foregroundColor(.white)
            .padding(.bottom, 25)
        }
    }
    
    @ViewBuilder private var footerView: some View {
        if viewModel.loginState.isLoggedIn {
            footerScoreView
        } else {
            footerButtonView
        }
    }
    
    @ViewBuilder private var footerButtonView: some View {
        VStack {
            Spacer(minLength: 34)
            
            Button {
                viewModel.auth()
            } label: {
                ZStack {
                    Color.white
                    
                    HStack(spacing: 15) {
                        Text("To play login with")
                            .font(.robotoCondensedRegular(size: 24))
                            .foregroundColor(.black)
                        
                        Image("blocto_logo")
                            .resizable()
                            .frame(width: 163.6, height: 34)
                    }
                    .offset(y: -5)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 71)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .ignoresSafeArea(.all, edges: .bottom)
    }
    
    @ViewBuilder private var footerScoreView: some View {
        VStack {
            Spacer()
            
            ZStack {
                Color.white
                
                ScoreView(
                    text: "Total\nScore",
                    score: viewModel.totalScore,
                    textColor: .flIndigo,
                    digitColor: .flPoints,
                    numberColor: .white)
                    .offset(y: -5)
                
            }
            .frame(height: 102)
            .cornerRadius(12)
        }
        .padding(.horizontal, 16)
    }
    
    @ViewBuilder private var playGameView: some View {
        if let game = viewModel.choosedGame {
            switch game {
            case .whereIsFlodo:
                FetchWaldoFlovatarsView()
            case .whachAFlovatar:
                ChooseYourPlayerView(
                    viewModel: ChooseYourPlayerViewModel(
                        address: viewModel.loginState.address,
                        choosedGame: viewModel.choosedGame))
            case .flovatarRunner:
                Text("flovatarRunner")
            }
        }
    }
}

#if DEBUG
struct MiniGamesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MiniGamesView(viewModel: MiniGamesViewModel(scoreModels: nil))
        }
    }
}
#endif
