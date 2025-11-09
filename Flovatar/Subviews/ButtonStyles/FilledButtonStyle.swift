//
//  FilledButtonStyle.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 04.01.2022.
//

import SwiftUI

struct FilledButtonStyle: ButtonStyle {
    
    let isFilled: Bool
    var backgroundColor: Color
    var textColor: Color
    
    init(isFilled: Bool, backgroundColor: Color = .white, textColor: Color = .flIndigo) {
        self.isFilled = isFilled
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.staatlichesRegular(size: 40))
            .minimumScaleFactor(0.8)
            .padding(.horizontal, 32)
            .frame(height: 70)
            .background(
                isFilled
                ? backgroundColor.opacity(configuration.isPressed ? 0.5 : 1)
                : backgroundColor.opacity(configuration.isPressed ? 0.1 : 0)
            )
            .foregroundColor(
                isFilled
                ? textColor.opacity(configuration.isPressed ? 0.5 : 1)
                : textColor.opacity(configuration.isPressed ? 0.5 : 1)
            )
            .cornerRadius(35)
            .overlay(
                RoundedRectangle(cornerRadius: 35)
                    .strokeBorder(
                        isFilled
                        ? Color.clear
                        : backgroundColor.opacity(configuration.isPressed ? 0.5 : 1)
                        , lineWidth: 3)
            )
    }
}

#if DEBUG
struct FilledButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundGradientView()
            
            VStack(alignment: .center, spacing: 20) {
                Button("YES") {
                    
                }
                .buttonStyle(FilledButtonStyle(isFilled: true))
                
                Button("NO") {
                }
                .buttonStyle(FilledButtonStyle(isFilled: false, textColor: .white))
                
                Button("PUBLIC FLOVATARS") {
                }
                .buttonStyle(FilledButtonStyle(isFilled: true, textColor: .flYellow))
            }
        }
    }
}
#endif
