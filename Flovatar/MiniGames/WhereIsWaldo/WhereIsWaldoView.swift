//
//  WhereIsWaldoView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 05.01.2022.
//

import SwiftUI

struct WhereIsWaldoView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: WhereIsWaldoViewModel
    
    private let screen = UIScreen.main.bounds.size
    
    var body: some View {
        ZStack {
            Color.midnightBlue
                .ignoresSafeArea()
            
            Image("SkyAndStarsWaldo")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack(spacing: 0) {
                headerView
                    .frame(width: screen.width)
                
                Spacer()
                
                gameFieldView
                    .scaleEffect(ScreenAdaptor.scaleFactor(screen: screen),
                                 anchor: .bottom)
            }
            .overlay(
                scoreView
                    .padding(.top, 15),
                alignment: .top
            )
            
            getReadyView
                .opacity(viewModel.readyToPlay ? 0 : 1)
            
            if viewModel.gameIsPaused {
                PausedGameView(
                    restartButton: viewModel.playAgain,
                    resumeButton: viewModel.playPauseGame
                )
            }
            
            if viewModel.gameTimeIsUp {
                SummaryView(
                    "TIME IS UP!",
                    buttonTitle: "Play Again",
                    score: viewModel.scoreCalculator.totalScore,
                    showTextField: true,
                    buttonAction: viewModel.playAgain
                )
                    .onDisappear {
                        viewModel.postScore()
                    }
            }
            
            if viewModel.gameLevelIsFinished {
                SummaryView(
                    "YOU DID IT!",
                    buttonTitle: "Next Level",
                    score: viewModel.scoreCalculator.levelScore,
                    buttonAction: viewModel.summaryBtnAction
                )
            }
            
            if viewModel.gameIsEnd {
                SummaryView(
                    "GAME OVER!",
                    buttonTitle: "Play Again",
                    score: viewModel.scoreCalculator.totalScore,
                    showTextField: true,
                    buttonAction: viewModel.playAgain
                )
                    .onDisappear {
                        viewModel.postScore()
                    }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
    }
    
    @ViewBuilder
    private var scoreView: some View {
        VStack {
            Text("SCORE")
                .font(.robotoCondensedBold(size: 26))
                .foregroundColor(.white)
            
            Text(String(viewModel.scoreCalculator.totalScore))
                .font(.robotoCondensedBold(size: 58))
                .foregroundColor(.flYellow)
        }
    }
    
    @ViewBuilder
    private var headerView: some View {
        HStack {
            CountdownTimerView(
                duration: viewModel.playGameDuration,
                timeElapsed: $viewModel.gameTimeElapsed,
                isActive: $viewModel.playGameTimerIsActive,
                isPaused: $viewModel.playGameTimerIsPaused,
                isFinish: $viewModel.playGameTimerIsFinished
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
    
    @ViewBuilder
    private var gameFieldView: some View {
        VStack(spacing: viewModel.currentLevelSetting.sectionSpacing) {
            ForEach(Array(viewModel.gameFieldArray.enumerated()), id: \.offset) { sectionIndex, section in
                HStack(spacing: viewModel.currentLevelSetting.rowSpacing) {
                    ForEach(Array(section.enumerated()), id: \.offset) { rowIndex, row in
                        imageView(row: row)
                            .frame(
                                width: viewModel.currentLevelSetting.flovatarSize.width,
                                height: viewModel.currentLevelSetting.flovatarSize.height
                            )
                            .onTapGesture {
                                viewModel.checkWinner(
                                    tapPosition: CGPoint(x: rowIndex, y: sectionIndex))
                            }
                            .offset(
                                x: CGFloat(Int.random(in: -10...10)),
                                y: CGFloat(Int.random(in: -10...10))
                            )
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func imageView(row: String) -> some View {
        if row == viewModel.waldoTag {
            SVGImage(image: Flovatar.waldo.svg!, needRemove: true, removeAfter: viewModel.currentLevelSetting.gameDuration + 5)
        } else {
            SVGImage(image: row, needRemove: true, removeAfter: viewModel.currentLevelSetting.gameDuration + 5)
        }
    }
    
    @ViewBuilder
    private var getReadyView: some View {
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
}

#if DEBUG
struct WhereIsWaldoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WhereIsWaldoView(viewModel: WhereIsWaldoViewModel(flovatars: []))
        }
    }
}
#endif
