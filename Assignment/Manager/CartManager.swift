//
//  CartManager.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import Foundation

class CartManager: ObservableObject {
    @Published private(set) var products: [ProductModel] = []
    @Published private(set) var total = 0
    
    let paymentHandler = PaymentHandler()
    @Published private(set) var paymentSuccess = false
    
    func addToChart(product: ProductModel) {
        products.append(product)
        total += product.price
    }
    
    func rmFromCart(product: ProductModel) {
        if let removeProduct = products.firstIndex(where: {$0.id == product.id}){
            products.remove(at: removeProduct)
        }
        //products = products.filter { $0.id != product.id }
        total -= product.price
    }
    
    func pay(){
        paymentHandler.startPayment(products: products, total: total){ success in
            self.paymentSuccess = success
            self.products = []
            self.total = 0
        }
    }
}



