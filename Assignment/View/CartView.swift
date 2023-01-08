//
//  CartView.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @StateObject var model = BiometricModel()
    @State var goCheckout = false
    
    var body: some View {
        NavigationView {
            ScrollView{
                if cartManager.products.count > 0 {
                    ForEach(cartManager.products, id: \.id){
                        product in ProductRow(product: product)
                    }
                    
                    HStack{
                        Text("Your cart total is")
                        Spacer()
                        Text("$\(cartManager.total).00")
                            .bold()
                    }
                    .padding()
                    
                    HStack{
                        Button(action: {
                            model.evaluatePolicy()
                            goCheckout = model.isAuthenicated
                        }, label: {
                            Text("Click to Checkout")
                        })
                    }
                    .sheet(isPresented: $goCheckout){
                        CheckoutView()
                    }
                    .padding()
                    .onAppear {
                        model.checkPolicy()
                        
                    }
                    
                    
                }else{
                    Text("Your cart is empty")
                }
            }
            .navigationTitle(Text("My Chart"))
            .padding(.top)
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
            .environmentObject(CartManager())
    }
}

