//
//  ScreenAdaptor.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 12.01.2022.
//

import Foundation
import UIKit

final class ScreenAdaptor {
    
    private let screenSize: CGSize = UIScreen.main.bounds.size
    private let figmaBorderOffset: CGSize = CGSize(width: 24, height: 20)
    
    
    // MARK: - Where’s Floldo
    static func scaleFactor(screen: CGSize) -> CGFloat {
        var result: CGFloat = 1
        
        switch screen {
        case CGSize(width: 375, height: 667): result = 0.961538461538462 // iP8, iP7, iP6s/6
        case CGSize(width: 375, height: 812): result = 0.961538461538462 // iP13Mini/12Mini, iP11Pro, iPXs/X
        case CGSize(width: 390, height: 844): result = 1                 // iP13/13Pro, iP12/12Pro
        case CGSize(width: 414, height: 736): result = 1.061538461538462 // iP8+, iP7+, iP6s+/6+
        case CGSize(width: 414, height: 896): result = 1.061538461538462 // iP11/11Pro Max, iPXr, iPXs
        case CGSize(width: 428, height: 926): result = 1.097435897435897 // iP13Pro Max, iP12Pro Max
        default: result = 1
        }
        
        return result
    }
    
    
    // MARK: - Whack-a-Flovatar
    func getHole(id: Int) -> HoleModel? {
        
        let xMul = getMultiplier(screen: screenSize).x
        let yMul = getMultiplier(screen: screenSize).y
        
        if holeModels.indices.contains(id) {
            let rawModel = holeModels[id]
            
            let newModel = HoleModel(
                holeID: rawModel.holeID,
                holeName: rawModel.holeName,
                holeFrame: CGRect(
                    x: (rawModel.holeFrame.origin.x + (rawModel.holeFrame.width / 2) - figmaBorderOffset.width) * xMul,
                    y: (rawModel.holeFrame.origin.y + (rawModel.holeFrame.height / 2) - figmaBorderOffset.height) * yMul,
                    width: rawModel.holeFrame.width * xMul,
                    height: rawModel.holeFrame.height * yMul),
                lightName: rawModel.lightName,
                lightFrame: CGRect(
                    x: (rawModel.lightFrame.origin.x + (rawModel.lightFrame.width / 2) - figmaBorderOffset.width) * xMul,
                    y: (rawModel.lightFrame.origin.y + (rawModel.lightFrame.height / 2) - figmaBorderOffset.height) * yMul,
                    width: rawModel.lightFrame.width * xMul,
                    height: rawModel.lightFrame.height * yMul
                ),
                flovatarFrame: CGRect(
                    x: (rawModel.flovatarFrame.origin.x + rawModel.holeFrame.origin.x + rawModel.flovatarFrame.width / 4) * xMul,
                    y: (rawModel.flovatarFrame.origin.y + rawModel.holeFrame.origin.y - rawModel.flovatarFrame.height / 2 + figmaBorderOffset.height) * yMul,
                    width: rawModel.flovatarFrame.width * xMul,
                    height: rawModel.flovatarFrame.height * yMul)
            )
            return newModel
        }
        
        return nil
    }
    
    // Dimensions from figma for iPhone 13
    private let holeModels: [HoleModel] = [
        HoleModel(holeID: 0, holeName: "hole0",
                  holeFrame: CGRect(x: 262.37, y: 304.52, width: 102.39, height: 17.19),
                  lightName: "light0",
                  lightFrame: CGRect(x: 256, y: 206, width: 114, height: 113),
                  flovatarFrame: CGRect(x: -4, y: -17, width: 120, height: 120)),
        HoleModel(holeID: 1, holeName: "hole1",
                  holeFrame: CGRect(x: 76.38, y: 376.75, width: 109.2, height: 18.33),
                  lightName: "light1",
                  lightFrame: CGRect(x: 71, y: 253, width: 122, height: 139),
                  flovatarFrame: CGRect(x: -4, y: -15, width: 140, height: 140)),
        HoleModel(holeID: 2, holeName: "hole2",
                  holeFrame: CGRect(x: 242.54, y: 445.78, width: 122.02, height: 20.49),
                  lightName: "light2",
                  lightFrame: CGRect(x: 235, y: 319, width: 136, height: 145),
                  flovatarFrame: CGRect(x: -4, y: -10, width: 160, height: 160)),
        HoleModel(holeID: 3, holeName: "hole3",
                  holeFrame: CGRect(x: 70.6, y: 533.13, width: 131.02, height: 22.31),
                  lightName: "light3",
                  lightFrame: CGRect(x: 64, y: 386, width: 146, height: 167.52),
                  flovatarFrame: CGRect(x: -4, y: -8, width: 180, height: 180)),
        HoleModel(holeID: 4, holeName: "hole4",
                  holeFrame: CGRect(x: 219.74, y: 631.05, width: 147.46, height: 25.11),
                  lightName: "light4",
                  lightFrame: CGRect(x: 210, y: 484, width: 164, height: 168.5),
                  flovatarFrame: CGRect(x: 0, y: -5, width: 200, height: 200)),
        HoleModel(holeID: 5, holeName: "hole5",
                  holeFrame: CGRect(x: 68.79, y: 734.99, width: 161.64, height: 27.52),
                  lightName: "light5",
                  lightFrame: CGRect(x: 61, y: 590, width: 180, height: 170),
                  flovatarFrame: CGRect(x: 0, y: 0, width: 220, height: 220))
    ]
    
    private func getMultiplier(screen: CGSize) -> CGPoint {
        var result: CGPoint = CGPoint(x: 1, y: 1)
        
        switch screen {
        case CGSize(width: 375, height: 667): result = CGPoint(x: 0.961538461538462, y: 0.790284360189573) // iP8, iP7, iP6s/6
        case CGSize(width: 375, height: 812): result = CGPoint(x: 0.961538461538462, y: 0.962085308056872) // iP13Mini/12Mini, iP11Pro, iPXs/X
        case CGSize(width: 390, height: 844): result = CGPoint(x: 1, y: 1) // iP13/13Pro, iP12/12Pro
        case CGSize(width: 414, height: 736): result = CGPoint(x: 1.061538461538462, y: 0.872037914691943) // iP8+, iP7+, iP6s+/6+
        case CGSize(width: 414, height: 896): result = CGPoint(x: 1.061538461538462, y: 1.061611374407583) // iP11/11Pro Max, iPXr, iPXs
        case CGSize(width: 428, height: 926): result = CGPoint(x: 1.097435897435897, y: 1.097156398104265) // iP13Pro Max, iP12Pro Max
        default: result = CGPoint(x: 1, y: 1)
        }
        
        return result
    }
}
