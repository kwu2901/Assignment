//
//  ShopView.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import SwiftUI

struct ShopView: View {
    @EnvironmentObject var productManager: ProductManager
    @StateObject var cartManager = CartManager()
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]

    var body: some View {

        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(productManager.products, id: \.id) {
                        product in ProductCard(product: product)
                            .environmentObject(cartManager)
                            .cornerRadius(20)
                    }
                }
                .padding()
                
            }
            .navigationTitle(Text("Shop"))
            .toolbar{
                NavigationLink{
                    CartView()
                        .environmentObject(cartManager)
                } label: {
                    CartButton(numOfProducts: cartManager.products.count)
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ShopView_Previews: PreviewProvider {
    static var previews: some View {
        ShopView()
            .environmentObject(ProductManager())
    }
}
