//
//  Extension+Color.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 04.01.2022.
//

import Foundation
import SwiftUI

extension Color {
    
    static var flYellow: Color {
        Color(hex: "#FFEE50")
    }
    
    static var flIndigo: Color {
        Color(hex: "#431C8F")
    }
    
    static var midnightBlue: Color {
        Color(hex: "#180E38")
    }
    
    static var fuchsia: Color {
        Color(hex: "#FF00F9")
    }
    
    static var flPoints: Color {
        Color(hex: "#9416CB")
    }
    
    static var lightPurple: Color {
        Color(hex: "#C7BCFB")
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
