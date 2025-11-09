//
//  HomeStep2ViewModel.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 17.01.2022.
//

import Foundation

final class HomeStep2ViewModel: ObservableObject {
    
    @Published var showLogOutView = false
    @Published var showLeaderBoardView = false
    @Published var playMiniGamesView = false
    
    @Published var totalScore: String = "0"
    
    var scoreModels: [ScoreModel]?
    
    var loginState = AuthHelper.shared
    
    // MARK: - INIT
    init(scoreModels: [ScoreModel]?) {
        self.scoreModels = scoreModels
        self.calculateTotalScores()
    }
    
    func homeStep2ViewDidAppear() {
        loadScore()
    }
    
    func logout() {
        loginState.logout()
        totalScore = "0"
        scoreModels = nil
    }
    
    func miniGamesButton() {
        playMiniGamesView = true
    }
    
    func leaderBoardButton() {
        showLeaderBoardView = true
    }
    
    private func loadScore() {
        if loginState.isLoggedIn {
                        
            let link = LinkBuilder()
                .getLeaderboard(address: loginState.address)
                .build()
            
            let apiClient = NFTAPIClient(url: link)
            
            apiClient.getScoreList { [weak self] result in
                switch result {
                case .success(let response):
                    DispatchQueue.main.async {
                        self?.scoreModels = response
                        
                        let summ = response.reduce(0) { x, y in
                            x + y.score
                        }
                        
                        self?.totalScore = String(summ)
                    }
                case .failure(let error):
                    print(#fileID, #line, "error", error)
                }
            }
        }
    }
    
    private func calculateTotalScores() {
        if let scoreModels = scoreModels {
            let summ = scoreModels.reduce(0) { x, y in
                x + y.score
            }
            
            totalScore = String(summ)
        }
    }
}
