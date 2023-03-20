//
//  fb4appApp.swift
//  fb4app
//
//  Created by Maurice Hennig on 20.03.23.
//

import SwiftUI

@main
struct fb4appApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
