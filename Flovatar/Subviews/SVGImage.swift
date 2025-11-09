//
//  SVGImage.swift
//  FCLDemo
//
//  Created by Yuriy Berdnikov on 30.11.2021.
//

import SwiftUI
import Macaw

struct SVGImage: UIViewRepresentable {
    
    var image: String
    let needRemove: Bool
    let removeAfter: Double
    
    init(image: String, needRemove: Bool = false, removeAfter: Double = 0) {
        self.image = image
        self.needRemove = needRemove
        self.removeAfter = removeAfter
    }
    
    func makeUIView(context: Context) -> SVGView {
        let svgView = SVGView()
        svgView.backgroundColor = UIColor(white: 1.0, alpha: 0.0) // otherwise the background is black
        svgView.isUserInteractionEnabled = false
        svgView.gestureRecognizers?.removeAll()
        return svgView
    }
    
    func updateUIView(_ uiView: SVGView, context: Context) {
        DispatchQueue.global(qos: .userInitiated).async {
            let svg = (try? SVGParser.parse(text: image)) ?? Group()
            
            DispatchQueue.main.async {
                uiView.node = svg
            }
            
            if needRemove {
                DispatchQueue.main.asyncAfter(deadline: .now() + removeAfter) {
                    uiView.node = Group()
                }
            }
        }
    }
}

#if DEBUG
struct SVGImage_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SVGImage(image: Flovatar.mock.svg!)
        }
        .padding()
    }
}
#endif
