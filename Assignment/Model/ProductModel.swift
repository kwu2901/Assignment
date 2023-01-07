//
//  ProductModel.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import Foundation
import UIKit

struct ProductModel: Identifiable, Codable{
    var id = UUID()
    var name: String
    var image: UIImage {
        do {
            return try FileManager().readImage(with: id)
        } catch {
            return UIImage(systemName: "photo.fill")!
        }
    }
    var dir: String
    var price: Int
}

extension ProductModel{
    static var productList = [
        ProductModel(name: "Room1", dir: "Night style", price: 100),
        ProductModel(name: "Room2", dir: "European style", price: 150),
        ProductModel(name: "Room3", dir: "Home style", price: 200),
    ]
}

