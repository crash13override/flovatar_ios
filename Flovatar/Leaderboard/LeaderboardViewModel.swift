//
//  LeaderboardViewModel.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 17.01.2022.
//

import Foundation

struct LeaderBoardModel: Identifiable {
    let id: String = UUID().uuidString
    let name: String
    let flowAddress: String
    let scores: String
}

final class LeaderboardViewModel: ObservableObject {
    
    @Published var leaderBoard: [LeaderBoardModel] = []
    
    func loadScoreList() {
        
        let link = LinkBuilder()
            .getLeaderboard(.whereIsFlodo)
            .build()
        
        let apiClient = NFTAPIClient(url: link)
        
        apiClient.getScoreList { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.leaderBoard = response.compactMap { item in
                        LeaderBoardModel(name: item.name ?? "",
                                         flowAddress: item.flowAddress,
                                         scores: String(item.score)
                        )
                    }
                }
            case .failure(let error):
                print(#fileID, #line, "error", error)
            }
        }
    }
}
