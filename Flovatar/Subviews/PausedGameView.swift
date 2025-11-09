//
//  PausedGameView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 21.01.2022.
//

import SwiftUI

struct PausedGameView: View {
    
    let title: String
    let restartButton: () -> Void
    let resumeButton: () -> Void
    
    @EnvironmentObject private var navigationUtil: NavigationUtil
    
    init(_ title: String = "PAUSED", restartButton: @escaping () -> Void, resumeButton: @escaping () -> Void) {
        self.title = title
        self.restartButton = restartButton
        self.resumeButton = resumeButton
    }
    
    var body: some View {
        ZStack {
            Color.midnightBlue
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Text("PAUSED")
                    .font(.robotoCondensedBold(size: 54))
                    .kerning(3.24)
                    .foregroundColor(.white)
                
                HStack(spacing: 40) {
                    VStack(spacing: 15) {
                        Button {
                            restartButton()
                        } label: {
                            ZStack {
                                Image("arrow.counterclockwise")
                                    .foregroundColor(.black)
                                    .frame(width: 32, height: 33)
                            }
                            .frame(width: 76, height: 76)
                            .background(Color.fuchsia)
                            .clipShape(Circle())
                        }
                        
                        Text("RESTART")
                            .font(.robotoCondensedBold(size: 22))
                            .foregroundColor(.white)
                    }
                    
                    VStack(spacing: 15) {
                        Button {
                            resumeButton()
                        } label: {
                            ZStack {
                                Image("play")
                                    .foregroundColor(.black)
                                    .frame(width: 38, height: 44)
                                    .offset(x: 5)
                            }
                            .frame(width: 92, height: 92)
                            .background(Color.flYellow)
                            .clipShape(Circle())
                        }
                        
                        Text("RESUME")
                            .font(.robotoCondensedBold(size: 26))
                            .foregroundColor(.white)
                    }
                    
                    VStack(spacing: 15) {
                        Button {
                            navigationUtil.backToRoot()
                        } label: {
                            ZStack {
                                Image("home")
                                    .resizable()
                                    .frame(width: 35, height: 36)
                                    .offset(y: -2)
                            }
                            .frame(width: 76, height: 76)
                            .background(Color.fuchsia)
                            .clipShape(Circle())
                        }
                        
                        Text("QUIT")
                            .font(.robotoCondensedBold(size: 22))
                            .foregroundColor(.white)
                    }
                }
            }
        }
    }
}

#if DEBUG
struct PausedGameView_Previews: PreviewProvider {
    static var previews: some View {
        PausedGameView { } resumeButton: { }
    }
}
#endif
