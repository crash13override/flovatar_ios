//
//  HomeStep1ViewModel.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 19.01.2022.
//

import Foundation

final class HomeStep1ViewModel: ObservableObject {
    
    @Published var showFlovatarsView: Bool = false
    @Published var showMiniGamesView: Bool = false
    @Published var showLogOutView: Bool = false
    @Published var saveScoreIsOn: Bool = false
    
    @Published var flovatar: Flovatar = Flovatar.emptyWhite
    @Published var totalScore: String = "0"
    var scoreModels: [ScoreModel]?
    
    var loginState = AuthHelper.shared
    var address: String = ""
    
    func homeStep1ViewDidAppear() {
        if loginState.isLoggedIn {
            loadTotalScoreAndFlovatar()
        } else {
            totalScore = "0"
            scoreModels = nil
        }
    }
    
    
    // MARK: - Buttons
    func publicFlovatars() {
        address = ""
        showFlovatarsView = true
    }
    
    func myFlovatars() {
        
        if loginState.isLoggedIn {
            address = loginState.address
            showFlovatarsView = true
        } else {
            auth()
        }
    }
    
    func miniGames() {
        showMiniGamesView = true
    }
    
    
    // MARK: - Login
    private func auth() {
        loginState.auth { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(address):
                    self?.address = address
                    self?.showFlovatarsView = true
                case let .failure(error):
                    print(#fileID, #line, "Error:", error.localizedDescription)
                }
            }
        }
    }
    
    func logout() {
        loginState.logout()
        totalScore = "0"
        scoreModels = nil
    }
    
    
    // MARK: - Fetch User Total Score & First Flovatar
    private func loadTotalScoreAndFlovatar() {
        
        let group = DispatchGroup()
        
        var flov: Flovatar?
        var score: String = ""
        
        // Fetch First Flovatar
        let linkFlovatar = LinkBuilder()
            .getFlovatars(forAddress: loginState.address, page: 1)
            .build()
        
        let apiClientFlovatar = NFTAPIClient(url: linkFlovatar)
        
        group.enter()
        apiClientFlovatar.listNFTsForAddress(address: address) { resultFlovatar in
            switch resultFlovatar {
            case let .success(response):
                if let first = response.data.first(where: { $0.svg != nil }) {
                    flov = first
                }
            case let .failure(error):
                print(error)
            }
            group.leave()
        }
        
        
        // Fetch User Total Score
        let linkScore = LinkBuilder()
            .getLeaderboard(address: loginState.address)
            .build()
        
        let apiClientScore = NFTAPIClient(url: linkScore)
        
        group.enter()
        apiClientScore.getScoreList { resultScore in
            switch resultScore {
            case .success(let response):
                self.scoreModels = response
                let summ = response.reduce(0) { x, y in
                    x + y.score
                }
                score = String(summ)
            case .failure(let error):
                print(#fileID, #line, "error", error)
            }
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            if let flov = flov {
                self.flovatar = flov
            }
            self.totalScore = score
        }
    }
}
