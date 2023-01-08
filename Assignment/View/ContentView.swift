//
//  ContentView.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabBar()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ProductManager())
    }
}
