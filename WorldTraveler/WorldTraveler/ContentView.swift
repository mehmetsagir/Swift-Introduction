//
//  ContentView.swift
//  WorldTraveler
//
//  Created by Mehmet Sağır on 5.05.2022.
//

import SwiftUI

struct ContentView: View {
    @State var fahrenheitValue = ""
    
    let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter
    }()
    
    func convertToCelsius() -> String {
        if let value = Double(fahrenheitValue) {
            let fahrenheit = Measurement<UnitTemperature>(value: value, unit: .fahrenheit)
            let celsiusValue = fahrenheit.converted(to: .celsius)
            return numberFormatter.string(from: NSNumber(value: celsiusValue.value)) ?? "???"
        } else {
            return "???"
        }
    }
    
    var body: some View {
        VStack {
            TextField("value", text: $fahrenheitValue)
                .multilineTextAlignment(.center)
                .font(Font.system(size: 64.0))
                .keyboardType(.decimalPad)
            Text("fahrenheit")
            Text("is actually")
                .foregroundColor(.gray)
            Text(convertToCelsius())
                .font(Font.system(size: 64))
            Text("degress Celcius")
            Spacer()
        }
        .foregroundColor(.orange)
        .font(.title)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
