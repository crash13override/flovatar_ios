//
//  WhereIsWaldoLevelModel.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 12.01.2022.
//

import Foundation
import UIKit

struct WhereIsWaldoLevelModel {
    var level: Int
    var gameDuration: Double
    let breakArray: UInt
    let cutArrayforCount: Int
    let flovatarSize: CGSize
    let flovatarOffset: CGSize
    let sectionSpacing: CGFloat
    let rowSpacing: CGFloat
    
    static var mock: WhereIsWaldoLevelModel {
        WhereIsWaldoLevelModel(
            level: 1,
            gameDuration: 60,
            breakArray: 6,
            cutArrayforCount: 48,
            flovatarSize: CGSize(width: 105, height: 105),
            flovatarOffset: CGSize(width: 0, height: 17),
            sectionSpacing: -40,
            rowSpacing: -45
        )
    }
    
    
    // MARK: - Levels
    
    // 6x8
    static var level_6x8x60s: WhereIsWaldoLevelModel {
        WhereIsWaldoLevelModel(
            level: 1,
            gameDuration: 60,
            breakArray: 6,
            cutArrayforCount: 48,
            flovatarSize: CGSize(width: 105, height: 105),
            flovatarOffset: CGSize(width: 0, height: 17),
            sectionSpacing: -40,
            rowSpacing: -45
        )
    }
    
    // 7x8
    static var level_7x8x60s: WhereIsWaldoLevelModel {
        WhereIsWaldoLevelModel(
            level: 2,
            gameDuration: 60,
            breakArray: 7,
            cutArrayforCount: 56,
            flovatarSize: CGSize(width: 99, height: 99),
            flovatarOffset: CGSize(width: 0, height: 17),
            sectionSpacing: -35,
            rowSpacing: -45
        )
    }
    
    // 8x9
    static var level_8x9x45s: WhereIsWaldoLevelModel {
        WhereIsWaldoLevelModel(
            level: 3,
            gameDuration: 45,
            breakArray: 8,
            cutArrayforCount: 72,
            flovatarSize: CGSize(width: 93, height: 93),
            flovatarOffset: CGSize(width: 0, height: 17),
            sectionSpacing: -35,
            rowSpacing: -49
        )
    }
    
    // 9x10
    static var level_9x10x30s: WhereIsWaldoLevelModel {
        WhereIsWaldoLevelModel(
            level: 4,
            gameDuration: 30,
            breakArray: 9,
            cutArrayforCount: 90,
            flovatarSize: CGSize(width: 86, height: 86),
            flovatarOffset: CGSize(width: 0, height: 14),
            sectionSpacing: -32,
            rowSpacing: -46
        )
    }
    
    // 10x11
    static var level_10x11x30s: WhereIsWaldoLevelModel {
        WhereIsWaldoLevelModel(
            level: 5,
            gameDuration: 20,
            breakArray: 10,
            cutArrayforCount: 110,
            flovatarSize: CGSize(width: 80, height: 80),
            flovatarOffset: CGSize(width: 0, height: 14),
            sectionSpacing: -32,
            rowSpacing: -43
        )
    }
    
    // 11x12
    static var level_11x12x15s: WhereIsWaldoLevelModel {
        WhereIsWaldoLevelModel(
            level: 6,
            gameDuration: 15,
            breakArray: 11,
            cutArrayforCount: 132,
            flovatarSize: CGSize(width: 74, height: 74),
            flovatarOffset: CGSize(width: 0, height: 11),
            sectionSpacing: -30,
            rowSpacing: -40
        )
    }
    
    // 12x13
    static var level_12x13x15s: WhereIsWaldoLevelModel {
        WhereIsWaldoLevelModel(
            level: 7,
            gameDuration: 15,
            breakArray: 12,
            cutArrayforCount: 156,
            flovatarSize: CGSize(width: 68, height: 68),
            flovatarOffset: CGSize(width: 0, height: 11),
            sectionSpacing: -28,
            rowSpacing: -38
        )
    }
    
    // 14x15
    static var level_13x14x10s: WhereIsWaldoLevelModel {
        WhereIsWaldoLevelModel(
            level: 8,
            gameDuration: 10,
            breakArray: 13,
            cutArrayforCount: 182,
            flovatarSize: CGSize(width: 61, height: 61),
            flovatarOffset: CGSize(width: 0, height: 19),
            sectionSpacing: -22,
            rowSpacing: -33
        )
    }
}
