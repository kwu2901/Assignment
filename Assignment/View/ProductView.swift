//
//  ProductView.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import SwiftUI

struct ProductView: View {
    @EnvironmentObject var cartManager: CartManager
    @Binding var showProduct: Bool
    var product: ProductModel
    
    var body: some View {
        ScrollView{
            Image(uiImage: product.image)
                .resizable()
                .scaledToFit()
                .aspectRatio(contentMode: .fill)
            
            VStack(spacing: 30){
                Text(product.name)
                    .font(.largeTitle)
                    .bold()
                    .multilineTextAlignment(.center)
                
                VStack(alignment: .leading, spacing: 20){
                    Text("Description:")
                        .font(.headline)
                        .bold()
                        
                    VStack(alignment: .leading, spacing: 20){
                        Text(product.dir)
                    }
                    
                    Text("Price:")
                        .font(.headline)
                        .bold()
                    
                    VStack(alignment: .leading, spacing: 20){
                        Text("$\(product.price)")
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding()
            
            Button {
                cartManager.addToChart(product: product)
                showProduct.toggle()
            } label: {
                Text("Add to cart")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.blue)
                    .cornerRadius(8)
                    .padding()
            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView(showProduct: .constant(true), product: ProductModel.productList[0])
            .environmentObject(CartManager())
    }
}
