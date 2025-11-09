//
//  FetchWaldoFlovatarsViewModel.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 10.02.2022.
//

import Foundation

final class FetchWaldoFlovatarsViewModel: ObservableObject {
    
    @Published var fetchWaldoFlovatarsDidEnd: Bool = false
    @Published var flovatars: [String] = [] {
        didSet {
            if flovatars.isEmpty {
                fetchWaldoFlovatarsDidEnd = false
            } else {
                fetchWaldoFlovatarsDidEnd = true
            }
        }
    }
    
    init() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.fetchNFTs()
        }
    }
    
    
    // MARK: - Fetch Flovatars
    private func fetchNFTs(pageNumber: Int = 1) {
        var result: [String] = []
        
        let randomElements: [Int] = Array<Int>.generateRandomUniqueNumbers(
            inRange: 1...5000,
            numbersCount: 182
        )
        
        for i in randomElements {
            let url = URL(string: "https://flovatar.com/api/image/nobg/\(i)")!
            let strImage = (try? String(contentsOf: url)) ?? Flovatar.mock.svg!
            result.append(strImage)
        }
        
        DispatchQueue.main.async {
            self.flovatars = result
        }
    }
}
