//
//  ImageModel.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import UIKit

struct ImageModel: Identifiable, Codable {
    var id = UUID()
    var name: String
    
    var image: UIImage {
        do {
            return try FileManager().readImage(with: id)
        } catch {
            return UIImage(systemName: "photo.fill")!
        }
    }
}

