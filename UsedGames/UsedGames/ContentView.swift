//
//  ContentView.swift
//  UsedGames
//
//  Created by Mehmet Sağır on 5.05.2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var gameStore = GameStore()
    @ObservedObject var imageStore = ImageStore()
    
    @State var gameToDelete: Game?
    
    var body: some View {
        NavigationView {
            List {
                ForEach(gameStore.games) { (game) in
                    NavigationLink(
                        destination: DetailView(
                            game: game,
                            gameStore: gameStore,
                            imageStore: imageStore,
                            name: game.name,
                            price: game.priceInDollas,
                            selectedPhoto: imageStore.image(forKey: game.itemKey)
                        )
                    ) {
                        GameListItem(game: game)
                    }
                }
                .onDelete(perform: { indexSet in
                    let gameToDelete = gameStore.game(at: indexSet)
                    self.gameToDelete = gameToDelete
                    if let gameToDelete = gameToDelete {
                        self.imageStore.deleteImage(forkey: gameToDelete.itemKey)
                    }
                    self.gameToDelete = gameStore.game(at: indexSet)
                    
                })
                .onMove(perform: { indices,
                    newOffset in
                    gameStore.move(indices: indices, to: newOffset)
                })
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Used Games")
            .navigationBarTitleDisplayMode(.automatic)
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                    gameStore.createGame()
                }, label: {
                    Text("Add")
                }))
            .animation(.easeIn, value: gameStore.games)
            .actionSheet(item: $gameToDelete) { (game) -> ActionSheet in
                ActionSheet(
                    title: Text("Are you sure?"),
                    message: Text("You will delete \(game.name)"),
                    buttons: [
                        .cancel(),
                        .destructive(Text("Delete"), action: {
                            if let indexSet = gameStore.indexSet(for: game) {
                                gameStore.delete(at: indexSet)
                            }
                        })
                    ])
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

