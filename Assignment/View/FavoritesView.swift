//
//  FavoritesView.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var productManager: ProductManager
    @EnvironmentObject var cartManager: CartManager
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(productManager.products, id: \.id) {
                        product in
                        if product.isFav{
                            ProductCard(product: product)
                                .cornerRadius(20)
                                .scaledToFit()
                        }
                    }
                }
                .padding()
                
            }
            .navigationTitle(Text("Favorites"))
            .toolbar{
                NavigationLink{
                    CartView()
                } label: {
                    CartButton(numOfProducts: cartManager.products.count)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
            .environmentObject(ProductManager())
            .environmentObject(CartManager())
    }
}

