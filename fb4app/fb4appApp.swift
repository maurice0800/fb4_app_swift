//
//  fb4appApp.swift
//  fb4app
//
//  Created by Maurice Hennig on 20.03.23.
//

import SwiftUI

@main
struct fb4appApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
                        print("\(key) = \(value) \n")
                    }
                }
        }
    }
}
