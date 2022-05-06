//
//  GameListItem.swift
//  UsedGames
//
//  Created by Mehmet Sağır on 7.05.2022.
//

import SwiftUI

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
                .animation(nil)
        }
        .padding(.vertical, 4)
    }
}

struct GameListItem_Previews: PreviewProvider {
    static var previews: some View {
        let item = GameListItem(game: Game(random: true))
            .padding(.horizontal)
            .previewLayout(.sizeThatFits)
        
        Group {
            item
            item.preferredColorScheme(.dark)
            item.environment(\.sizeCategory, .accessibilityExtraLarge)
            item.environment(\.locale, Locale(identifier: "tr"))
        }
    }
}
