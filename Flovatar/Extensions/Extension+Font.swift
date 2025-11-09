//
//  Extension+Font.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 30.12.2021.
//

import Foundation
import SwiftUI

extension Font {
    static func staatlichesRegular(size: CGFloat) -> Font {
        return Font.custom("Staatliches-Regular", size: size)
    }
    
    static func robotoCondensedBold(size: CGFloat) -> Font {
        return Font.custom("RobotoCondensed-Bold", size: size)
    }
    
    static func robotoCondensedRegular(size: CGFloat) -> Font {
        return Font.custom("RobotoCondensed-Regular", size: size)
    }
}
