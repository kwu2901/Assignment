//
//  ProductManager.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import Foundation

class ProductManager: ObservableObject {
    @Published private(set) var products: [ProductModel] = []
    @Published var showFileAlert = false
    @Published var appError: ErrorController.ErrorType?
    
    init() {
        loadMyImagesJSONFile()
    }
    
    func addToProductList(product: ProductModel) {
        products.append(product)
    }
    
    func rmFromProductList(product: ProductModel) {
        if let removeProduct = products.firstIndex(where: {$0.id == product.id}){
            products.remove(at: removeProduct)
        }
    }
    
    //using to init product list
    func loadMyImagesJSONFile() {
        do {
            let data = try FileManager().readDocument()
            let decoder = JSONDecoder()
            do {
                products = try decoder.decode([ProductModel].self, from: data)
            } catch {
                showFileAlert = true
                appError = ErrorController.ErrorType(error: .decodingError)
            }
        } catch {
            showFileAlert = true
            appError = ErrorController.ErrorType(error: error as! ErrorController)
        }
    }
    
    //update product fav function
    func updateProduct(_ product: ProductModel) {
        if let index = products.firstIndex(where: {$0.id == product.id}) {
            products[index].isFav.toggle()
        }
    }
}
