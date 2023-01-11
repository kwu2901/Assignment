//
//  TabBar.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import SwiftUI

struct TabBar: View {
    @State private var root: String = ""
    var body: some View {
        TabView {
            ShopView()
                .tabItem {
                    Label("Shop", systemImage: "house")
                }
            
            if root == "Admin" {
                NewProductView()
                    .tabItem{
                        Label("New", systemImage: "plus")
                    }
            }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart")
                }
            
            SettingView(root: $root)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
            .environmentObject(ProductManager())
    }
}
