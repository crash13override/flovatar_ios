//
//  MiniGamesViewModel.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 19.01.2022.
//

import Foundation

final class MiniGamesViewModel: ObservableObject {
    
    @Published var gameDidChoose: Bool = false
    @Published var totalScore: String = "000"
    @Published var showLoadingFlovatarsView: Bool = true
    
    var loginState = AuthHelper.shared
    private var address: String = ""
    
    var choosedGame: MiniGames? = nil
    var scoreModels: [ScoreModel]?
    
    @Published var games: [MiniGameRowModel] = [
        MiniGameRowModel(game: .whereIsFlodo,
                         image: "whereIsFlodo",
                         title: "Where’s\nFloldo",
                         score: nil)]
    
    init(scoreModels: [ScoreModel]?) {
        self.scoreModels = scoreModels
        
        if AuthHelper.shared.isLoggedIn {
#warning("Only for presentation, after uncoment")
            //            self.address = AuthHelper.shared.address
            self.createRowWithScores()
            self.calculateTotalScores()
        }
    }
    
    
    // MARK: - Buttons
    func choose(miniGame: MiniGames) {
        choosedGame = miniGame
        
        if loginState.isLoggedIn {
            gameDidChoose = true
        } else {
            auth()
        }
    }
    
    
    // MARK: - Login
    func auth() {
        loginState.auth { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(address):
#warning("Only for presentation, after uncoment")
                    //                    self.address = address
                    
#warning("SET Real Data to games")
                    if self.choosedGame != nil {
                        self.gameDidChoose = true
                    }
                    
                    self.loadScore()
                    
                case let .failure(error):
                    print(#fileID, #line, "Error:", error.localizedDescription)
                }
            }
        }
    }
    
    func logout() {
        loginState.logout()
    }
    
    
    // MARK: - Fetch Scores
    func loadScore() {
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
                        self?.createRowWithScores()
                        self?.calculateTotalScores()
                    }
                case .failure(let error):
                    print(#fileID, #line, "error", error)
                }
            }
        }
    }
    
    
    // MARK: - Calculate Total Scores
    
    private func createRowWithScores() {
        if let scoreModels = scoreModels {
            let filtered = scoreModels.filter { $0.game == 0 }
            let summ = filtered.reduce(0) { x, y in
                x + y.score
            }
            
            games = [MiniGameRowModel(game: .whereIsFlodo,
                                      image: "whereIsFlodo",
                                      title: "Where’s\nFloldo",
                                      score: String(summ))]
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
