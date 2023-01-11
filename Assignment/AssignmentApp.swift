//
//  AssignmentApp.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import SwiftUI

@main
struct AssignmentApp: App {
    @StateObject var productManager = ProductManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(CameraModel())
                .environmentObject(CartManager())
                .environmentObject(productManager)
                .onAppear{
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}

