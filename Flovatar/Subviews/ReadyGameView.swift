//
//  ReadyGameView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 21.01.2022.
//

import SwiftUI

struct ReadyGameView<Content: View>: View {
    
    let content: () -> Content
    
    @EnvironmentObject private var navigationUtil: NavigationUtil
    private let screen = UIScreen.main.bounds.size
    
    var body: some View {
        ZStack {
            Color.midnightBlue
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Button {
                        navigationUtil.backToRoot()
                    } label: {
                        ZStack {
                            Image("home")
                                .resizable()
                                .frame(width: 22, height: 22.5)
                                .offset(y: -2)
                        }
                        .frame(width: 44, height: 44)
                        .background(Color.fuchsia)
                        .clipShape(Circle())
                    }
                    .padding(.leading, 32)
                    
                    Spacer()
                }
                Spacer()
            }
            
            content()
        }
        .frame(width: screen.width)
    }
}

#if DEBUG
struct ReadyGameView_Previews: PreviewProvider {
    static var previews: some View {
        ReadyGameView {
            Text("Hello")
                .font(.robotoCondensedBold(size: 40))
                .foregroundColor(.white)
        }
    }
}
#endif
