//
//  GameStore.swift
//  UsedGames
//
//  Created by Mehmet Sağır on 6.05.2022.
//

import Foundation

class GameStore: ObservableObject {
    @Published var games: [Game] = []
    
    init() {
        for _ in 0..<5 {
            createGame()
        }
    }
    
    @discardableResult func createGame() -> Game {
        let game = Game(random: true)
        games.append(game)
        return game
    }
}
