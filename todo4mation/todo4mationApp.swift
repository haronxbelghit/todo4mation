//
//  todo4mationApp.swift
//  todo4mation
//
//  Created by Belghit Haron on 6/4/2023.
//

import SwiftUI
import CoreData

@main
struct todo4mationApp: App {
    let persistenceController = PersistenceController.shared

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
}
