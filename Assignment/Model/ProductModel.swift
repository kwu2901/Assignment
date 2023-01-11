//
//  ProductModel.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import Foundation
import UIKit
import SwiftyJSON

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
    var isFav: Bool
}

extension ProductModel{
    static var productList = [
        ProductModel(name: "Room1", dir: "Night style", price: 100, isFav: false),
        ProductModel(name: "Room2", dir: "European style", price: 150, isFav: false),
        ProductModel(name: "Room3", dir: "Home style", price: 200, isFav: false),
    ]
}

