//
//  Bookworm_CoreDataApp.swift
//  Bookworm-CoreData
//
//  Created by Brando Lugo on 2/8/21.
//

import SwiftUI

@main
struct Bookworm_CoreDataApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

