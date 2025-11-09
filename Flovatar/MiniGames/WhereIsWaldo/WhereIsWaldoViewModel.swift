//
//  WhereIsWaldoViewModel.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 05.01.2022.
//

import Foundation
import UIKit

final class WhereIsWaldoViewModel: ObservableObject {
    
    let waldoTag: String = "waldo"
    
    private var loginState = AuthHelper.shared
    
    private var currentLevel: Int = 1 {
        didSet { infoLevel() }
    }
    
    private var gameLevels: [WhereIsWaldoLevelModel] = WhereIsWaldoLevels.levelsPack1
    
    var currentLevelSetting: WhereIsWaldoLevelModel {
        var setting: WhereIsWaldoLevelModel = WhereIsWaldoLevelModel.mock
        
        if gameLevels.indices.contains(currentLevel - 1) {
            setting = gameLevels[currentLevel - 1]
        } else {
            print(#fileID, #line, "Error: ‼️Level \(currentLevel) doesn`t exist‼️")
        }
        
        return setting
    }
    
    var flovatars: [String] = []
    @Published var gameFieldArray: [[String]] = []
    @Published var readyToPlay: Bool = false
    @Published var gameIsPaused: Bool = false
    @Published var gameIsEnd: Bool = false
    @Published var gameTimeIsUp: Bool = false
    
    
    // MARK: - Score Calculator
    let scoreCalculator = ScoreCalculator.shared
    
    private func setScore() {
        scoreCalculator.calculateLevel(
            remainingSeconds: playGameDuration - gameTimeElapsed,
            totalSeconds: playGameDuration,
            currentLevel: currentLevel,
            totalLevels: gameLevels.count
        )
    }
    
    private func resetScore() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.scoreCalculator.resetScore()
        }
    }
    
    
    // MARK: - Summary by Level
    @Published var gameLevelIsFinished: Bool = false {
        didSet {
            if gameLevelIsFinished {
                playGameTimerIsPaused = true
            }
        }
    }
    
    func summaryBtnAction() {
        nextLevel()
    }
    
    
    // MARK: - Loading Game
    let loadingDuration: Double = 3
    var loadingTimeElapsed: Double = 0
    @Published var loadingIsActive: Bool = true
    @Published var loadingIsFinished: Bool = false {
        didSet {
            if loadingIsFinished {
                loadingIsActive = !loadingIsFinished
                readyToPlay = loadingIsFinished
                playGameTimerIsActive = readyToPlay
            }
        }
    }
    
    
    // MARK: - Play Game
    var playGameDuration: Double = 60
    var gameTimeElapsed: Double = 0
    @Published var playGameTimerIsActive: Bool = false
    @Published var playGameTimerIsPaused: Bool = false
    @Published var playGameTimerIsFinished: Bool = false {
        didSet {
            playGameTimerIsActive = !playGameTimerIsFinished
            gameTimeIsUp = playGameTimerIsFinished
        }
    }
    
    
    // MARK: - Init
    init(flovatars: [String]) {
        self.flovatars = flovatars
        
        self.setGameFieldArray()
        self.insertWaldo()
        self.setGameDuration()
        self.addCaptureObserver()
    }
    
    func playPauseGame() {
        gameIsPaused.toggle()
        playGameTimerIsPaused.toggle()
    }
    
    func playAgain() {
        currentLevel = 1
        restartGame()
        resetScore()
    }
    
    private func restartGame() {
        readyToPlay = false
        gameIsPaused = false
        gameTimeIsUp = false
        loadingIsActive = true
        playGameTimerIsActive = false
        playGameTimerIsPaused = false
        gameLevelIsFinished = false
        gameIsEnd = false
        
        setGameFieldArray()
        insertWaldo()
        setGameDuration()
    }
    
    func checkWinner(tapPosition: CGPoint) {
        let area = createActiveArea(forPoint: tapPosition)
        
        if gameFieldArray[Int(tapPosition.y)][Int(tapPosition.x)] == waldoTag {
            setScore()
            gameLevelIsFinished = true
            gameFieldArray.removeAll()
        } else {
            for i in area {
                let x = Int(i.x)
                let y = Int(i.y)
                
                if gameFieldArray.indices.contains(y)
                    && gameFieldArray[y].indices.contains(x)
                    && gameFieldArray[y][x] == waldoTag {
                    setScore()
                    gameLevelIsFinished = true
                    gameFieldArray.removeAll()
                }
            }
        }

        if !gameLevelIsFinished {
            gameIsEnd = true
            gameFieldArray.removeAll()
        }
    }
    
    private func setGameFieldArray() {
        gameFieldArray = flovatars.shuffled()
            .cutArray(forCount: currentLevelSetting.cutArrayforCount)
            .breakInto(piecesOf: currentLevelSetting.breakArray)
    }
    
    private func setGameDuration() {
        playGameDuration = currentLevelSetting.gameDuration
        gameTimeElapsed = 0
    }
    
    private func nextLevel() {
        if currentLevel < gameLevels.count {
            currentLevel += 1
            restartGame()
        } else {
            restartGame()
        }
    }
    
    private func createActiveArea(forPoint: CGPoint) -> [CGPoint] {
        [CGPoint(x: forPoint.x - 1, y: forPoint.y),
         CGPoint(x: forPoint.x + 1, y: forPoint.y),
         CGPoint(x: forPoint.x, y: forPoint.y - 1),
         CGPoint(x: forPoint.x, y: forPoint.y + 1),
         
         CGPoint(x: forPoint.x - 1, y: forPoint.y - 1),
         CGPoint(x: forPoint.x + 1, y: forPoint.y - 1),
         CGPoint(x: forPoint.x - 1, y: forPoint.y + 1),
         CGPoint(x: forPoint.x + 1, y: forPoint.y + 1)]
    }
    
    private func insertWaldo() {
        if !gameFieldArray.isEmpty {
            let ranX = Int.random(in: gameFieldArray.indices)
            let ranY = Int.random(in: gameFieldArray[ranX].indices)

            gameFieldArray[ranX][ranY] = waldoTag
        }
    }
    
    
    // MARK: - Post Score
    func postScore() {
        if let name = UserDefaults.standard.string(forKey: Constant.userName),
           !name.isEmpty,
           scoreCalculator.totalScore > 0 {
            
            let link = LinkBuilder()
                .postLeaderboard()
                .build()
            
            let apiClient = NFTAPIClient(url: link)
            apiClient.postScore(model: ScoreModel(
                id: 0,
                name: name,
                flowAddress: loginState.address,
                score: scoreCalculator.totalScore,
                game: MiniGames.whereIsFlodo.rawValue,
                createdAt: "",
                updatedAt: "")
            )
            
            UserDefaults.standard.removeObject(forKey: Constant.userName)
        }
    }
    
    
    // MARK: - Prevent Screen Capture
    
    private func addCaptureObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(didTakeScreenshot(notification:)), name: UIApplication.userDidTakeScreenshotNotification, object: nil)
    }
    
    @objc private func didTakeScreenshot(notification:Notification) -> Void {
        gameIsEnd = true
        playGameTimerIsPaused = true
    }
    
    
    // MARK: - Info
    private func infoLevel() {
        print(#fileID, #line,
"""
        \n✅ Started Level: \(currentLevelSetting.level)
🥏 Field: \(currentLevelSetting.breakArray)x\(currentLevelSetting.cutArrayforCount / Int(currentLevelSetting.breakArray))
⏰ Duration: \(currentLevelSetting.gameDuration)
""")
    }
}
