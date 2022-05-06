//
//  UsedGames+Formatter.swift
//  UsedGames
//
//  Created by Mehmet Sağır on 7.05.2022.
//

import Foundation

struct Formatter {
    static let dollarFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencySymbol = "$"
        formatter.currencyCode = "USD"
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 2
        return formatter
    }()
}
