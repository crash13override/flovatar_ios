//
//  ScoreView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 17.01.2022.
//

import SwiftUI

struct ScoreView: View {
    
    let text: String
    let score: String
    let textColor: Color
    let digitColor: Color
    let numberColor: Color
    
    init(text: String, score: String, textColor: Color = .white, digitColor: Color = .white, numberColor: Color = .flPoints) {
        self.text = text
        self.score = score
        self.textColor = textColor
        self.digitColor = digitColor
        self.numberColor = numberColor
    }
    
    var body: some View {
        HStack(spacing: 24) {
            Text(text)
                .font(.robotoCondensedBold(size: 28))
                .foregroundColor(textColor)
                .multilineTextAlignment(.center)
            
            HStack(spacing: 4) {
                ForEach(Array(score).compactMap { String($0) }, id: \.self) { item in
                    ZStack {
                        Text(item)
                            .font(.robotoCondensedBold(size: 32))
                            .foregroundColor(numberColor)
                    }
                    .frame(width: 36, height: 48)
                    .background(digitColor)
                    .cornerRadius(6)
                }
            }
        }
    }
}

#if DEBUG
struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BackgroundGradientView()
            
            VStack {
                ScoreView(text: "Your\nScore", score: "25341")
                
                ScoreView(text: "Your Score", score: "25341")
                
                ScoreView(
                    text: "Total\nScore",
                    score: "25341",
                    textColor: .flYellow,
                    digitColor: .flYellow,
                    numberColor: .midnightBlue
                )
            }
        }
    }
}
#endif
