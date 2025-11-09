//
//  WhackAFlovatarView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 24.01.2022.
//

import SwiftUI

struct WhackAFlovatarView: View {
    
    @ObservedObject var viewModel: WhackAFlovatarViewModel
    
    var body: some View {
        ZStack {
            ZStack {
                Image("WhackAFlovatarBackground")
                    .resizable()
                ForEach(viewModel.activeHoleArray) { item in
                    WhackAFlovatarHoleView(id: item.id, flovatar: item.flovatar)
                        .onTapGesture {
                            viewModel.flovDidTap(id: item.id)
                        }
                }
            }
            .ignoresSafeArea()
            .onReceive(viewModel.timer) { _ in
                viewModel.timerPublished()
            }
            
            VStack {
                headerView
                
                Spacer()
            }
            .overlay(
                scoreView
                    .padding(.top, 15),
                alignment: .top
            )
            
            getReadyView
                .opacity(viewModel.readyToPlay ? 0 : 1)
            
            PausedGameView(
                restartButton: viewModel.playAgain,
                resumeButton: viewModel.playPauseGame
            )
                .opacity(viewModel.gameIsPaused ? 1 : 0)
            
            SummaryView("TIME IS UP!",
                        buttonTitle: "NEXT LEVEL",
                        score: viewModel.gameScore,
                        buttonAction: viewModel.playAgain
            )
                .opacity(viewModel.gameIsFinished ? 1 : 0)
        }
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    var getReadyView: some View {
        ReadyGameView {
            VStack(spacing: 10) {
                CountdownTimerView(
                    duration: viewModel.loadingDuration,
                    timeElapsed: $viewModel.loadingTimeElapsed,
                    isActive: $viewModel.loadingIsActive,
                    isPaused: .constant(false),
                    isFinish: $viewModel.loadingIsFinished
                )
                    .frame(width: 96, height: 96)
                
                Text("GET READY")
                    .font(.robotoCondensedBold(size: 54))
                    .kerning(3.24)
                    .foregroundColor(.white)
            }
        }
    }
    
    @ViewBuilder
    var scoreView: some View {
        VStack {
            Text("SCORE")
                .font(.robotoCondensedBold(size: 26))
                .foregroundColor(.white)
            
            Text(String(viewModel.gameScore))
                .font(.robotoCondensedBold(size: 58))
                .foregroundColor(.flYellow)
        }
    }
    
    @ViewBuilder
    var headerView: some View {
        HStack {
            ProgressCircleView(
                progressValue: viewModel.progressText.0,
                textValue: viewModel.progressText.1
            )
                .frame(width: 60, height: 60)
            
            Spacer()
            
            Button {
                viewModel.playPauseGame()
            } label: {
                ZStack {
                    Image(systemName: "pause.circle.fill")
                        .foregroundColor(Color.fuchsia)
                        .font(.system(size: 44))
                }
                .clipShape(Circle())
            }
        }
        .padding(.horizontal, 32)
    }
}

#if DEBUG
struct WhackAFlovatarView_Previews: PreviewProvider {
    static var previews: some View {
        WhackAFlovatarView(viewModel: WhackAFlovatarViewModel(flovatars: []))
    }
}
#endif
