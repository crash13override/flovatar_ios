//
//  CapsuleButtonStyle.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 19.01.2022.
//

import SwiftUI

struct CapsuleButtonStyle: ButtonStyle {
    
    var backgroundColor: Color
    var textColor: Color
    
    init(backgroundColor: Color = .white, textColor: Color = .flIndigo) {
        self.textColor = textColor
        self.backgroundColor = backgroundColor
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.staatlichesRegular(size: 40))
            .minimumScaleFactor(0.8)
            .padding(.horizontal, 30)
            .frame(height: 70)
            .frame(maxWidth: .infinity)
            .background(backgroundColor.opacity(configuration.isPressed ? 0.5 : 1))
            .foregroundColor(textColor.opacity(configuration.isPressed ? 0.5 : 1))
            .clipShape(Capsule())
    }
}

#if DEBUG
struct CapsuleButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundGradientView()
            
            VStack(alignment: .center, spacing: 20) {
                Button("YES") {
                    
                }
                .buttonStyle(CapsuleButtonStyle())
                
                Button("NO OK?") {
                }
                .buttonStyle(CapsuleButtonStyle())
                
                Button("PUBLIC FLOVATARS") {
                }
                .buttonStyle(CapsuleButtonStyle())
            }
            .padding()
        }
    }
}
#endif
