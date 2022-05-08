//
//  DetailView.swift
//  UsedGames
//
//  Created by Mehmet Sağır on 7.05.2022.
//

import SwiftUI

struct DetailView: View {
    var game: Game
    
    @State var name: String = ""
    @State var price: Double = 0.0
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading, spacing: 6.0) {
                    Text("Name")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField("Name", text: $name)
                }.padding(.vertical, 4.0)
                VStack(alignment: .leading, spacing: 6.0) {
                    Text("Price in Dollars")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    TextField("Price",
                              value: $price,
                              formatter: Formatter.dollarFormatter
                    )
                        .keyboardType(.decimalPad)
                }.padding(.vertical, 4.0)
            }
            Section {
                Button(action: {}, label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                })
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        let game = Game(random: true)
        DetailView(game: game)
    }
}
