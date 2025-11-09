//
//  LinkBuilder.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 27.01.2022.
//

import Foundation

final class LinkBuilder {

    private let scheme:          String = "https"
    private let host:            String = "flovatar.com"

    // Paths
    private var path:            String = ""
    private var pathAPI:         String = "/api"
    private var pathGame:        String = "/game"
    private var pathLeaderboard: String = "/leaderboard"
    private var pathAddress:     String = "/address"
    private var pathCollection:  String = "/collection"

    // Queries
    private var queryPage: String = "page"
    
    private var queryItems: [URLQueryItem] = []
    
    // Methods
    func getFlovatars(forAddress: String? = nil, page: Int = 1) -> LinkBuilder {
        var link = pathCollection + pathAPI
        
        if let address = forAddress, !address.isEmpty {
            link += (address.isEmpty ? "" : "/\(address)")
        }
        
        queryItems.append(URLQueryItem(name: queryPage, value: "\(page)"))
        
        path = link
        return self
    }

    func getLeaderboard(_ miniGame: MiniGames) -> LinkBuilder {
        path = pathAPI + pathLeaderboard + pathGame + "/\(miniGame.rawValue)"
        return self
    }

    func getLeaderboard(address: String) -> LinkBuilder {
        path = pathAPI + pathLeaderboard + pathAddress + "/" + address
        return self
    }
    
    func postLeaderboard() -> LinkBuilder {
        path = pathAPI + pathLeaderboard
        return self
    }

    func build() -> URL {
        var urlComp = URLComponents()
        urlComp.scheme = scheme
        urlComp.host = host
        urlComp.path = path
        
        if !queryItems.isEmpty {
            urlComp.queryItems = queryItems
        }
        
        return urlComp.url!
    }
}
