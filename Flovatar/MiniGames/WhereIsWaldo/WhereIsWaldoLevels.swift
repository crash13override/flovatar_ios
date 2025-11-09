//
//  WhereIsWaldoLevels.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 12.01.2022.
//

import Foundation
import UIKit

struct LevelDuration {
    let forLevels: ClosedRange<Int>
    let seconds: Double
}

struct WhereIsWaldoLevels {
    
    static var levelsPackTEST: [WhereIsWaldoLevelModel] {
        WhereIsWaldoLevelsBuilder()
            .addLevel(
                .level_13x14x10s
            )
            .build()
    }
    
    static var levelsPack0: [WhereIsWaldoLevelModel] {
        WhereIsWaldoLevelsBuilder()
            .addLevel(
                .level_6x8x60s,
                .level_7x8x60s,
                .level_8x9x45s,
                .level_9x10x30s,
                .level_10x11x30s,
                .level_11x12x15s,
                .level_12x13x15s,
                .level_13x14x10s
            )
            .build()
    }
    
    static var levelsPack1: [WhereIsWaldoLevelModel] {
        WhereIsWaldoLevelsBuilder()
            .addLevels(.level_7x8x60s, count: 2)
            .addLevels(.level_8x9x45s, count: 2)
            .addLevels(.level_9x10x30s, count: 2)
            .addLevels(.level_10x11x30s, count: 2)
            .addLevels(.level_11x12x15s, count: 2)
            .addLevels(.level_12x13x15s, count: 2)
            .addLevels(.level_13x14x10s, count: 2)
            .addLevelDuration(
                LevelDuration(forLevels: 1...3, seconds: 60),
                LevelDuration(forLevels: 4...6, seconds: 45),
                LevelDuration(forLevels: 7...9, seconds: 30),
                LevelDuration(forLevels: 10...11, seconds: 20),
                LevelDuration(forLevels: 12...13, seconds: 15),
                LevelDuration(forLevels: 14...5000, seconds: 10)
            )
            .build()
    }
}
