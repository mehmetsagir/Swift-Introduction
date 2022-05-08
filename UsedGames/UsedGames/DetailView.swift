//
//  DetailView.swift
//  UsedGames
//
//  Created by Mehmet Sağır on 7.05.2022.
//

import SwiftUI
import Combine

struct DetailView: View {
    var game: Game
    
    var gameStore: GameStore
    
    @State var name: String = ""
    @State var price: Double = 0.0
    
    @State var shouldEnableSaveButton: Bool = false
    
    func validate() {
        shouldEnableSaveButton = game.name != name || game.priceInDollas != price
     }
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 6.0) {
                    Text("Name")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField("Name", text: $name)
                        .onReceive(Just(name), perform: { newValue in
                            validate()
                        })
                }
                .padding(.vertical, 4.0)
                VStack(alignment: .leading, spacing: 6.0) {
                    Text("Price in Dollars")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField("Price",
                              value: $price,
                              formatter: Formatter.dollarFormatter
                    )
                    .onReceive(Just(price), perform: { newValue in
                        validate()
                    })
                        .keyboardType(.decimalPad)
                }
                .padding(.vertical, 4.0)
            }
            Section {
                Button(action: {
                    let newGame = Game(name: name, priceInDollas: price, serialNumber: game.serialNumber)
                    gameStore.update(game: game, newValue: newGame)
                }, label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                })
                    .disabled(!shouldEnableSaveButton)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let gameStore = GameStore()
        let game = gameStore.createGame()

        DetailView(game: game, gameStore: gameStore)
    }
}
