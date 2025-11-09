//
//  WhackAFlovatarHoleView.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 24.01.2022.
//

import SwiftUI

struct WhackAFlovatarHoleView: View {
    
    let id: Int
    let flovatar: Flovatar
    private let positioner = ScreenAdaptor()
    
    var body: some View {
        if let fire = positioner.getHole(id: id) {
            ZStack {
                Image(fire.holeName)
                    .resizable()
                    .frame(
                        width: fire.holeFrame.size.width,
                        height: fire.holeFrame.size.height
                    )
                    .position(fire.holeFrame.origin)
                
                Image(fire.lightName)
                    .resizable()
                    .frame(
                        width: fire.lightFrame.size.width,
                        height: fire.lightFrame.size.height
                    )
                    .position(fire.lightFrame.origin)
                
                if let svg = flovatar.svg, !svg.isEmpty {
                    SVGImage(image: svg)
                        .frame(
                            width: fire.flovatarFrame.width,
                            height: fire.flovatarFrame.height
                        )
                        .position(
                            x: fire.flovatarFrame.origin.x,
                            y: fire.flovatarFrame.origin.y
                        )
                }
            }
        }
    }
}

#if DEBUG
struct WhackAFlovatarHoleView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            WhackAFlovatarHoleView(id: 5, flovatar: Flovatar.mock)
        }
    }
}
#endif
