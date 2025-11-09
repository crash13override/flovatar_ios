//
//  ScoreCalculator.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 25.01.2022.
//

import Foundation

final class ScoreCalculator {
    static let shared = ScoreCalculator()
    private init() {}
    
    private var levelsScore: [Int] = []
    
    var levelScore: Int {
        levelsScore.isEmpty ? 0 : levelsScore.last!
    }
    
    var totalScore: Int {
        levelsScore.reduce(0, +)
    }
    
    func calculateLevel(
        remainingSeconds: Double,
        totalSeconds: Double,
        currentLevel: Int,
        totalLevels: Int
    ) {
        var result: Int = 0
        
        let seconds: Double = remainingSeconds > totalSeconds ? totalSeconds : remainingSeconds / totalSeconds
        let level: Double = currentLevel > totalLevels ? Double(totalLevels) : Double(currentLevel) / Double(totalLevels)
        
        result = Int(100.0 + (100.0 * (seconds + level)))
        levelsScore.append(result)
    }
    
    func resetScore() {
        levelsScore.removeAll()
    }
}
