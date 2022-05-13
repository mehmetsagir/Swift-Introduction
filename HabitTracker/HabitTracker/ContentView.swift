 //
//  ContentView.swift
//  HabitTracker
//
//  Created by Mehmet Sağır on 13.05.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello")
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
