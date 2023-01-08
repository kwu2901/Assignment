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
    @StateObject var productManager = ProductManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(CameraModel())
                .environmentObject(productManager)
                .onAppear{
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}

