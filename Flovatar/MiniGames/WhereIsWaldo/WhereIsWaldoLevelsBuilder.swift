//
//  WhereIsWaldoLevelsBuilder.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 16.02.2022.
//

import Foundation

final class WhereIsWaldoLevelsBuilder {
    
    private var levels: [WhereIsWaldoLevelModel] = []
    private var levelsDuration: [LevelDuration] = []
    
    func addLevel(_ level: WhereIsWaldoLevelModel...) -> WhereIsWaldoLevelsBuilder {
        levels.append(contentsOf: level)
        return self
    }
    
    func addLevels(_ level: WhereIsWaldoLevelModel, count: Int) -> WhereIsWaldoLevelsBuilder {
        levels.append(contentsOf: Array(repeating: level, count: count))
        return self
    }
    
    func addLevelDuration(_ duration: LevelDuration...) -> WhereIsWaldoLevelsBuilder {
        levelsDuration.append(contentsOf: duration)
        return self
    }

    func build() -> [WhereIsWaldoLevelModel] {
        
        for index in levels.indices {
            levels[index].level = index + 1
        }
        
        for levelsDur in levelsDuration {
            for (index, level) in levels.enumerated() {
                if levelsDur.forLevels.contains(level.level) {
                    levels[index].gameDuration = levelsDur.seconds
                }
            }
        }
        
        return levels
    }
}
