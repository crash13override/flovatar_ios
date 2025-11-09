//
//  ChooseYourPlayerViewModel.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 10.02.2022.
//

import Foundation

final class ChooseYourPlayerViewModel: ObservableObject {

    @Published var showLoadingFlovatarsView: Bool = true
    @Published var flovatars: [Flovatar] = [] {
        didSet {
            if flovatars.isEmpty {
                showLoadingFlovatarsView = true
            } else {
                showLoadingFlovatarsView = false
            }
        }
    }
    
    private var address: String
    private var loginState = AuthHelper.shared
    
    var choosedGame: MiniGames?
    
    
    // MARK: - INIT
    init(address: String, choosedGame: MiniGames?) {
        self.address = address
        self.choosedGame = choosedGame
    }
    
    
    // MARK: - Fetch Flovatars
    
    // needs to be replaced with blockchain address lookup
    func fetchNFTs(pageNumber: Int = 1) {
        // let apiClient = NFTAPIClient(url: URL(string: "https://flovatar.com/collection/api/0x715eba9a0dd9d21a")!)
        
        let link = LinkBuilder()
            .getFlovatars(forAddress: address, page: pageNumber)
            .build()
        
        let apiClient = NFTAPIClient(url: link)
        apiClient.listNFTsForAddress(address: address) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self?.loadedPageNumber = response.currentPage
                    self?.setFlovatarsFrom(response: response.data)
                    self?.isLoadingNextPage = false
                case let .failure(error):
                    print(error)
                }
            }
        }
    }
    
    private func setFlovatarsFrom(response: [Flovatar]) {
        if loginState.isLoggedIn && response.isEmpty {
            flovatars.append(Flovatar.waldo)
        } else {
            flovatars.append(contentsOf: response)
        }
    }
    
    
    // MARK: - Pagination
    
    @Published var isLoadingNextPage: Bool = false
    
    private var loadedPageNumber: Int = 1
    
    func current(index: Int) {
        if shouldLoadNextPage(currentIndex: index) {
            loadNextPage()
        }
    }
    
    private func loadNextPage() {
        if !isLoadingNextPage {
            isLoadingNextPage = true
            fetchNFTs(pageNumber: loadedPageNumber + 1)
        }
    }
    
    private func shouldLoadNextPage(currentIndex: Int) -> Bool {
        
        var result: Bool = false
        let numFromEnd: Int = 3
        
        if flovatars.count > numFromEnd && currentIndex >= flovatars.count - numFromEnd {
            result = true
        }
        
        return result
    }
}
