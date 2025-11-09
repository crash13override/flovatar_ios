//
//  MiniGameRowModel.swift
//  Flovatar
//
//  Created by Yuriy Berdnikov on 20.01.2022.
//

import Foundation

struct MiniGameRowModel {
    let game: MiniGames
    let image: String
    let title: String
    let score: String?
    
    static func mock(withScore: Bool) -> [MiniGameRowModel] {
        if withScore {
           return [
                MiniGameRowModel(game: .whereIsFlodo, image: "whereIsFlodo", title: "Where’s\nFloldo", score: "0"),
                MiniGameRowModel(game: .whachAFlovatar, image: "whachAFlovatar", title: "Whack-a-\nFlovatar", score: "124"),
                MiniGameRowModel(game: .flovatarRunner, image: "flovatarRunner", title: "Flovatar\nRunner", score: "101"),
            ]
        } else {
           return [
                MiniGameRowModel(game: .whereIsFlodo, image: "whereIsFlodo", title: "Where’s\nFloldo", score: nil),
                MiniGameRowModel(game: .whachAFlovatar, image: "whachAFlovatar", title: "Whack-a-\nFlovatar", score: nil),
                MiniGameRowModel(game: .flovatarRunner, image: "flovatarRunner", title: "Flovatar\nRunner", score: nil),
            ]
        }
    }
}
