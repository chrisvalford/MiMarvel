//
//  MiMarvelApp.swift
//  Shared
//
//  Created by Christopher Alford on 4/8/21.
//

import SwiftUI

@main
struct MiMarvelApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
