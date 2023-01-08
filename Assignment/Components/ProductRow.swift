//
//  ProductRow.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var cartManager: CartManager
    var product: ProductModel
    var body: some View {
        HStack(spacing: 20){
            Image(uiImage: product.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .cornerRadius(10)
            
            VStack(alignment: .leading, spacing: 20){
                Text(product.name)
                    .bold()
                
                Text("$\(product.price)")
            }
            Spacer()
            Image(systemName: "trash")
                .foregroundColor(Color(hue: 1.0, saturation: 0.89, brightness: 0.835))
                .onTapGesture {
                    
                    cartManager.rmFromCart(product: product)
                }
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ProductRow_Previews: PreviewProvider {
    static var previews: some View {
        ProductRow(product: ProductModel.productList[0])
            .environmentObject(CartManager())
    }
}


