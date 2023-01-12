//
//  ProductCard.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import SwiftUI

struct ProductCard: View {
    @EnvironmentObject var cartManager: CartManager
    @EnvironmentObject var productManager: ProductManager
    @State var showProduct = false
    
    var networkHandler = NetworkHandler()
    
    var product : ProductModel
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Button{
                showProduct = true
            }label:{
                ZStack(alignment: .bottom) {
                    Image(uiImage: product.image)
                        .resizable()
                        .cornerRadius(20)
                        .frame(width: 180)
                        .scaledToFit()
                    
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .bold()
                            .foregroundColor(.white)
                        
                        Text("\(product.price)$")
                            .font(.caption)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(width: 180, alignment: .leading)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                }
                .frame(width: 180, height: 250)
                .shadow(radius: 3)
            }
            .sheet(isPresented: $showProduct){
                ProductView(showProduct: $showProduct, product: product)
            }
                Button {
                    productManager.updateProduct(product)
                } label: {
                    Image(systemName: product.isFav ? "star.fill" : "star")
                        .padding(10)
                        .foregroundColor(product.isFav ? .yellow : .white)
                        .background(.black)
                        .cornerRadius(50)
                        .padding()
                }
            
        }
    }
}

struct ProductCardView_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: ProductModel.productList[0])
            .environmentObject(CartManager())
            .environmentObject(ProductManager())
    }
}
