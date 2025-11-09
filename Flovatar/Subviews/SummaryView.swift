//
//  SummaryView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 11.01.2022.
//

import SwiftUI

struct SummaryView: View {
    
    @EnvironmentObject private var navigationUtil: NavigationUtil
    
    private let screen = UIScreen.main.bounds.size
    
    @State private var userName: String = ""
    @State private var btnActive: Bool = true
    
    let title: String
    let buttonTitle: String
    let score: Int
    let showTextField: Bool
    let buttonAction: () -> Void
    
    init(
        _ title: String,
        buttonTitle: String,
        score: Int,
        showTextField: Bool = false,
        buttonAction: @escaping () -> Void
    ) {
        self.title = title
        self.buttonTitle = buttonTitle
        self.score = score
        self.buttonAction = buttonAction
        self.showTextField = showTextField
    }
    
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
            
            VStack(spacing: 10) {
                Text(title)
                    .font(.robotoCondensedBold(size: 54))
                    .kerning(3.24)
                    .foregroundColor(.white)
                
                ScoreView(
                    text: "\(showTextField ? "Total" : "Your") Score",
                    score: String(score)
                )
                
                textFieldView
                
                Button(buttonTitle) {
                    buttonAction()
                }
                .buttonStyle(Rectangle3DButtonStyle(btnColor: .flYellow))
                .frame(width: 214)
                .padding(.top, showTextField ? 24 : 54)
            }
        }
        .frame(width: screen.width)
    }
    
    @ViewBuilder private var textFieldView: some View {
        if showTextField {
            VStack {
                ZStack {
                    TextField("", text: $userName)
                        .placeholder(when: userName.isEmpty, alignment: .center) {
                            Text("Enter Your Name")
                                .foregroundColor(.gray.opacity(0.5))
                        }
                        .font(.staatlichesRegular(size: 32))
                        .foregroundColor(.flYellow)
                        .frame(width: 318, height: 73)
                        .multilineTextAlignment(.center)
                }
                .border(Color.flYellow, width: 4)
                
                Button("SAVE") {
                    saveUserName()
                    buttonAction()
                }
                .buttonStyle(Rectangle3DButtonStyle(btnColor: btnActive ? .flYellow : .gray))
                .frame(width: 214)
                .padding(.top, 24)
                .disabled(btnActive ? false : true)
            }
            .padding(.top, 20)
            .onAppear {
                btnActive = !userName.isEmpty
            }
            .onChange(of: userName) { newValue in
                if !newValue.isEmpty {
                    btnActive = true
                } else {
                    btnActive = false
                }
            }
        }
    }

    private func saveUserName() {
        if !userName.isEmpty {
            UserDefaults.standard.set(userName, forKey: Constant.userName)
            hideKeyboard()
        }
    }
    
    private func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#if DEBUG
struct TimeIsUpView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView("TIME IS UP!", buttonTitle: "Play Again", score: 245, showTextField: true) { }
    }
}
#endif
