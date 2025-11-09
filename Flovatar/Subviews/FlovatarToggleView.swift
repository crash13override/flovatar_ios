//
//  FlovatarToggleView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 02.02.2022.
//

import SwiftUI

struct FlovatarToggleView: View {
    
    @Binding var isOn: Bool
    
    var body: some View {
        RoundedRectangle(cornerRadius: 16, style: .circular)
            .fill(isOn ? .white : Color(hex: "#9968D3"))
            .frame(width: 42, height: 24)
            .overlay(
                Circle()
                    .fill(isOn ? Color.flPoints : Color.white)
                    .frame(width: 16, height: 16)
                    .offset(x: isOn ? 8 : -8)
            )
            .onTapGesture {
                withAnimation {
                    isOn.toggle()
                }
            }
    }
}

#if DEBUG
struct FlovatarToggleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.pink
            
            VStack {
                FlovatarToggleView(isOn: .constant(true))
                FlovatarToggleView(isOn: .constant(false))
            }
        }
        .ignoresSafeArea()
    }
}
#endif
