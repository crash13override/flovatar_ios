//
//  BackgroundGradientView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 30.12.2021.
//

import SwiftUI

struct BackgroundGradientView: View {
    
    let stars: String?
    
    init(stars: String? = "Stars01") {
        self.stars = stars
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 1.00, green: 0.00, blue: 0.98), Color(red: 0.26, green: 0.11, blue: 0.56)]),
                startPoint: .top, endPoint: .bottom
            )
            
            if let stars = stars {
                VStack {
                    Image(stars)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 34)
                        .padding(.top, 40)
                    
                    Spacer()
                }
            }
        }
        .ignoresSafeArea()
    }
}

#if DEBUG
struct BackgroundGradientView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGradientView()
    }
}
#endif
