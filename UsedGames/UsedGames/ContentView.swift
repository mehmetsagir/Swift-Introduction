//
//  ContentView.swift
//  UsedGames
//
//  Created by Mehmet Sağır on 5.05.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gameStore = GameStore()
    
    var body: some View {
        List {
            HStack {
                Spacer()
                Button(action: {
                    gameStore.createGame()
                }, label: {
                    Text("Add")
                }).buttonStyle(BorderlessButtonStyle())
            }
            ForEach(gameStore.games) { (game) in
                GameListItem(game: game)
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct GameListItem: View {
    var game: Game
    var numberFormatter = Formatter.dollarFormatter
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4.0) {
                Text(game.name)
                    .font(.body)
                Text(game.serialNumber)
                    .font(.caption)
                    .foregroundColor(Color(white: 0.65))
            }
            Spacer()
            Text(NSNumber(value: game.priceInDollas), formatter: numberFormatter)
                .font(.title2)
                .foregroundColor(game.priceInDollas > 30 ? .blue : .gray)
        }
        .padding(.vertical, 4)
    }
}
