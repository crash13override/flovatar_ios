//
//  LoadingView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 02.02.2022.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.midnightBlue
            
            LottieView(name: "pong")
                .frame(width: 150, height: 150)
        }
        .ignoresSafeArea()
    }
}

#if DEBUG
struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
#endif
