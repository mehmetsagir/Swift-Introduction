//
//  WorldTravelerApp.swift
//  WorldTraveler
//
//  Created by Mehmet Sağır on 5.05.2022.
//

import SwiftUI

@main
struct WorldTravelerApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                ContentView()
                    .tabItem {
                        HStack {
                            Image(systemName: "thermometer")
                            Text("Conversion")
                        }
                    }
                MapView()
                    .tabItem {
                        HStack {
                            Image(systemName: "map")
                            Text("Map")
                        }
                    }
            }
//            .accentColor(.purple)
        }
    }
}

