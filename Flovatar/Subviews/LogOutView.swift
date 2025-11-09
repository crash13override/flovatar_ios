//
//  LogOutView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 19.01.2022.
//

import SwiftUI

struct LogOutView: View {
    
    @Binding var isShowed: Bool
    let logOutAction: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.85)
            
            ZStack {
                Color.flYellow
                
                VStack(spacing: 30) {
                    Text("Are you sure you\nwant to logout?")
                        .font(.robotoCondensedBold(size: 30))
                        .multilineTextAlignment(.center)
                    
                    HStack(spacing: 25) {
                        Button("LOGOUT") {
                            isShowed = false
                            logOutAction()
                        }
                        .buttonStyle(Rectangle3DButtonStyle(textColor: .white, btnColor: .flIndigo))
                        .frame(width: 122)
                        
                        Button("NO") {
                            isShowed = false
                        }
                        .buttonStyle(Rectangle3DButtonStyle(btnColor: .flYellow))
                        .frame(width: 104)
                    }
                }
            }
            .frame(height: 260)
            .cornerRadius(8)
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea()
    }
}

#if DEBUG
struct LogOutView_Previews: PreviewProvider {
    static var previews: some View {
        LogOutView(isShowed: .constant(true)) {}
    }
}
#endif
