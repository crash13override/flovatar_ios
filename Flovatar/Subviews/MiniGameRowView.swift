//
//  MiniGameRowView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 18.01.2022.
//

import SwiftUI

struct MiniGameRowView: View {
    
    let model: MiniGameRowModel
    
    var body: some View {
        ZStack {
            Color.flYellow
            
            HStack {
                Image(model.image)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .padding(.leading, 12)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(model.title)
                        .font(.robotoCondensedBold(size: 30))
                        .foregroundColor(.midnightBlue)
                        .minimumScaleFactor(0.8)
                        .multilineTextAlignment(.leading)
                    
                    if let score = model.score {
                        HStack {
                            Text("Score:")
                                .font(.robotoCondensedRegular(size: 22))
                                .foregroundColor(.midnightBlue.opacity(0.5))
                            
                            Text(score)
                                .font(.robotoCondensedBold(size: 22))
                                .foregroundColor(.flPoints)
                        }
                    }
                }
                .padding(.leading)
                
                Spacer()
            }
        }
        .frame(height: 104)
        .cornerRadius(8)
        .overlay(
            Image("Beta"), alignment: .bottomTrailing)
    }
}

#if DEBUG
struct MiniGameRowView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ForEach(MiniGameRowModel.mock(withScore: true), id: \.title) { game in
                MiniGameRowView(model: game)
            }
            
            ForEach(MiniGameRowModel.mock(withScore: false), id: \.title) { game in
                MiniGameRowView(model: game)
            }
        }
        .padding()
    }
}
#endif
