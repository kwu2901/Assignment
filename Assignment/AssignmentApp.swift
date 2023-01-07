//
//  AssignmentApp.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import SwiftUI

@main
struct AssignmentApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
