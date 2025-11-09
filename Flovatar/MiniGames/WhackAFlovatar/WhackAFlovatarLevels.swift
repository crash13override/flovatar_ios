//
//  WhackAFlovatarLevels.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 25.01.2022.
//

import Foundation

struct WhackAFlovatarLevelModel {
    let level: Int
    let gameDuration: Double
    let gameSpeed: Double
    
    static var mock: WhackAFlovatarLevelModel {
        WhackAFlovatarLevelModel(level: 1, gameDuration: 60, gameSpeed: 1)
    }
}

struct WhackAFlovatarLevels {
    static let levelsPack0: [WhackAFlovatarLevelModel] = [
        WhackAFlovatarLevelModel(level: 1, gameDuration: 60, gameSpeed: 1),
        WhackAFlovatarLevelModel(level: 2, gameDuration: 45, gameSpeed: 0.9),
        WhackAFlovatarLevelModel(level: 3, gameDuration: 30, gameSpeed: 0.8),
        WhackAFlovatarLevelModel(level: 4, gameDuration: 30, gameSpeed: 0.7),
        WhackAFlovatarLevelModel(level: 5, gameDuration: 30, gameSpeed: 0.6)
    ]
}
