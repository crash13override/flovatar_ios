//
//  SVGUrlImage.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 22.02.2022.
//

import SwiftUI
import Macaw

@available(*, deprecated, message: "NOT USE")
struct SVGUrlImage: UIViewRepresentable {

    var imageNumber: String
    let needRemove: Bool
    let removeAfter: Double
    
    init(imageNumber: String, needRemove: Bool = false, removeAfter: Double = 0) {
        self.imageNumber = imageNumber
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
            let url = URL(string: "https://flovatar.com/api/image/nobg/\(imageNumber)")!
            
            let strImage = (try? String(contentsOf: url)) ?? Flovatar.mock.svg!
            let svg = (try? SVGParser.parse(text: strImage)) ?? Group()

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
struct SVGUrlImage_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SVGUrlImage(imageNumber: "300")
        }
        .padding()
    }
}
#endif
