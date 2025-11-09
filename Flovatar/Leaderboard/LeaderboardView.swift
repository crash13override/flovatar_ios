//
//  LeaderboardView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 17.01.2022.
//

import SwiftUI

struct LeaderboardView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: LeaderboardViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.flIndigo
                    .ignoresSafeArea()
                
                VStack {
                    Text("LEADERBOARD")
                        .font(.robotoCondensedBold(size: 40))
                        .foregroundColor(.white)
                        .kerning(2)
                        .padding(.top, 40)
                    
                    if viewModel.leaderBoard.isEmpty {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                            .scaleEffect(1.5)
                    }
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        ForEach(Array(viewModel.leaderBoard.enumerated()), id: \.offset) { index, model in
                            leaderBoardRow(index: index, model: model)
                                .transition(.scale(scale: 0, anchor: .top))
                        }
                        .animation(.default)
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                trailing:
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "multiply")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .foregroundColor(.white)
                            .padding(.trailing, 20)
                    }
            )
            .onAppear(perform: viewModel.loadScoreList)
        }
    }
    
    private func leaderBoardRow(index: Int, model: LeaderBoardModel) -> some View {
        ZStack {
            Color(hex: index % 2 == 0 ? "#AE3DDF" : "#9416CB")
            
            HStack(spacing: 0) {
                Text("\(index + 1)")
                    .padding(.trailing, 20)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(model.name)
                    Text(model.flowAddress)
                        .font(.robotoCondensedRegular(size: 20))
                }
                
                Spacer()
                
                Text(model.scores)
            }
            .font(.robotoCondensedBold(size: 22))
            .foregroundColor(.white)
            .padding(.horizontal, 22)
        }
        .frame(height: 68)
    }
}

#if DEBUG
struct LeaderboardView_Previews: PreviewProvider {
    static var previews: some View {
        LeaderboardView(viewModel: LeaderboardViewModel())
    }
}
#endif
