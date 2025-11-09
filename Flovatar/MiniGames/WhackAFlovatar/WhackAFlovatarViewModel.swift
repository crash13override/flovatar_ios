//
//  WhackAFlovatarViewModel.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 24.01.2022.
//

import Foundation

struct FieldHomeModel: Identifiable {
    let id: Int
    let flovatar: Flovatar
}

final class WhackAFlovatarViewModel: ObservableObject {
    private var flovatarStorage: [Flovatar]
    
    @Published var activeHoleArray: [FieldHomeModel] = []
    
    var gameScore: Int = 0
    
    
    // MARK: - Game Levels
    private var currentLevel: Int = 1
    private var gameLevels: [WhackAFlovatarLevelModel] = WhackAFlovatarLevels.levelsPack0
    
    private var currentLevelSetting: WhackAFlovatarLevelModel {
        var setting: WhackAFlovatarLevelModel = WhackAFlovatarLevelModel.mock
        
        if gameLevels.indices.contains(currentLevel - 1) {
            setting = gameLevels[currentLevel - 1]
        } else {
            print(#fileID, #line, "Error: ‼️Level \(currentLevel) doesn`t exist‼️")
        }
        return setting
    }
    
    
    // MARK: - Game Timer
    @Published var elapsedTime: Double = 0
    
    var timerCount: Double = 0
    var timer = Timer.publish(every: 0.5, on: .current, in: .common).autoconnect()
    
    var progressText: (Double, Double) {
        ((100 / playGameDuration) * elapsedTime, playGameDuration - elapsedTime)
    }
    
    
    // MARK: - Init
    init(flovatars: [Flovatar]) {
        self.flovatarStorage = flovatars.filter { $0.svg != nil }
        self.setGameDuration()
    }
    
    private func setGameDuration() {
        playGameDuration = currentLevelSetting.gameDuration
    }
    
    
    // MARK: - Loading Game
    let loadingDuration: Double = 5
    var loadingTimeElapsed: Double = 0
    @Published var loadingIsActive: Bool = true
    @Published var loadingIsFinished: Bool = false {
        didSet {
            if loadingIsFinished {
                startGame()
            }
        }
    }
    
    
    // MARK: - Play Game
    private var playGameDuration: Double = 60
    @Published var readyToPlay: Bool = false
    @Published var gameIsActive: Bool = false
    @Published var gameIsPaused: Bool = false
    @Published var gameIsFinished: Bool = false
    
    func timerPublished() {
        countingElapsedTime()
        timerCount += currentLevelSetting.gameSpeed
    }
    
    private func countingElapsedTime() {
        if elapsedTime == playGameDuration {
            gameIsActive = false
            gameIsFinished = true
        } else {
            if gameIsActive && !gameIsPaused {
                if Int(timerCount) != Int(elapsedTime) {
                    elapsedTime += 1
                }
                showFlovatar()
            }
        }
    }
    
    func startGame() {
        timer = Timer.publish(every: currentLevelSetting.gameSpeed, on: .current, in: .common).autoconnect()
        loadingIsActive = !loadingIsFinished
        readyToPlay = loadingIsFinished
        gameIsActive = readyToPlay
    }
    
    func playPauseGame() {
        gameIsPaused.toggle()
    }
    
    func playAgain() {
        currentLevel = 1
        restartGame()
    }
    
    func nextLevel() {
        if currentLevel < gameLevels.count {
            currentLevel += 1
            restartGame()
        } else {
            restartGame()
        }
    }
    
    private func restartGame() {
        readyToPlay = false
        gameIsActive = false
        gameIsPaused = false
        gameIsFinished = false
        
        loadingIsActive = true
        
        elapsedTime = 0
        gameScore = 0
        setGameDuration()
    }
    
    private func showFlovatar() {
        var result: [FieldHomeModel] = []
        
        for _ in 0...Int.random(in: 0...1) {
            result.append(FieldHomeModel(
                id: Int.random(in: 0...5),
                flovatar: flovatarStorage.randomElement() ?? Flovatar.mock
            ))
        }
        activeHoleArray = result
    }
    
    func flovDidTap(id: Int) {
        if activeHoleArray.count > 1 {
            if let index = activeHoleArray.firstIndex(where: { $0.id == id }) {
                activeHoleArray.remove(at: index)
            }
        } else {
            activeHoleArray.removeAll()
        }
        gameScore += 1
    }
}
