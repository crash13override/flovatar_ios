//
//  NavigationUtil.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 16.02.2022.
//

import Foundation

class NavigationUtil: ObservableObject {
    @Published var showRoot: Bool = false
    
    func backToRoot() {
        showRoot = true
    }
}
