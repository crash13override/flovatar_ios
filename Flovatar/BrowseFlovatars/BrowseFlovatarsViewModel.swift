//
//  BrowseFlovatarsViewModel.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 02.02.2022.
//

import Foundation

final class BrowseFlovatarsViewModel: ObservableObject {

    @Published var showLoadingFlovatarsView: Bool = true
    @Published var flovatars: [Flovatar] = []
    
    private var address: String
    private var loginState = AuthHelper.shared
    
    // MARK: - INIT
    init(address: String) {
        self.address = address
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
                    self?.lastPageNumber = response.lastPage
                    self?.flovatars.append(contentsOf: response.data)
                    self?.isLoadingNextPage = false
                    self?.showProgressView = false
                    self?.showLoadingFlovatarsView = false
                case let .failure(error):
                    self?.showLoadingFlovatarsView = false
                    print(error)
                }
            }
        }
    }
    
    
    // MARK: - Pagination
    
    @Published var showProgressView: Bool = false
    var isLoadingNextPage: Bool = false
    
    private var loadedPageNumber: Int = 1
    private var lastPageNumber: Int = 0
    
    func current(index: Int) {
        if shouldLoadNextPage(currentIndex: index)
            && loadedPageNumber < lastPageNumber {
            loadNextPage()
        }
    }
    
    private func loadNextPage() {
        if !isLoadingNextPage {
            isLoadingNextPage = true
            showProgressView = true
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
