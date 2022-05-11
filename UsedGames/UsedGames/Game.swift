//
//  Game.swift
//  UsedGames
//
//  Created by Mehmet Sağır on 6.05.2022.
//

import Foundation

class Game: NSObject, Identifiable {
    var name: String
    var priceInDollas: Double
    var serialNumber: String
    var dateCreated: Date
    let itemKey: String
    
    init(name: String, priceInDollas: Double, serialNumber: String) {
        self.name = name
        self.priceInDollas = priceInDollas
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        self.itemKey = UUID().uuidString
    }
    
    convenience init(random: Bool = false) {
        if random {
            let conditions = ["New", "Mint", "Used"]
            var idx = Int.random(in: 0..<conditions.count)
            let randomCondition = conditions[idx]
            let names = ["Resident Evil", "Gears of War", "Halo", "God of War"]
            idx = Int.random(in: 0..<names.count)
            let randomName = names[idx]
            idx = Int.random(in: 0..<6)
            let randomTitle = "\(randomCondition) \(randomName) \(idx)"
            let serialNumber = UUID().uuidString.components(separatedBy: "-").first!
            let priceInDollars = Double.random(in: 0...70)
            self.init(name: randomTitle, priceInDollas: priceInDollars, serialNumber: serialNumber)
        } else {
            self.init(name: "", priceInDollas: 0, serialNumber: "")
        }
    }
}
