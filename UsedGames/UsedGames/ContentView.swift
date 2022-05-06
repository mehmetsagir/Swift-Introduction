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
            ForEach(gameStore.games) { (game) in
                GameListItem(game: game)
            }
            .onDelete(perform: { indexSet in
                gameStore.delete(at: indexSet)
            })
            .onMove(perform: { indices,
                newOffset in
                gameStore.move(indices: indices, to: newOffset)
            })
        }.padding(EdgeInsets(top: 28, leading: 0, bottom: 0, trailing: 0))
        .animation(.easeIn, value: gameStore.games)
        .overlay(
            VStack {
                HStack {
                    EditButton()
                    Spacer()
                    Button(action: {
                        gameStore.createGame()
                    }, label: {
                        Text("Add")
                    }).buttonStyle(BorderlessButtonStyle())
                }
                .padding()
                .background(Color.white.edgesIgnoringSafeArea(.top))
                Spacer()
            }
        )
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
