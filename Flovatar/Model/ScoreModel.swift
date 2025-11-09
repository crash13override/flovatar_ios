//
//  ScoreModel.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 27.01.2022.
//

import Foundation

struct ScoreModel: Codable {
    let id: Int
    let name: String?
    let flowAddress: String
    let score: Int
    let game: Int
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case flowAddress = "flow_address"
        case score, game
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
