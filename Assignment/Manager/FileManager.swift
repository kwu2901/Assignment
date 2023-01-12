//
//  FileManager.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import UIKit

let fileName = "MyProducts.json"

extension FileManager {
    static var docDirURL: URL {
        return Self.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func docExist(named docName: String) -> Bool {
        fileExists(atPath: Self.docDirURL.appendingPathComponent(docName).path)
    }
    
    //saving JSON file of local
    func saveDocument(contents: String) throws {
        let url = Self.docDirURL.appendingPathComponent(fileName)
        do {
            try contents.write(to: url, atomically: true, encoding: .utf8)
        } catch {
            throw ErrorController.saveError
        }
    }
    
    //laod JSON file of local
    func readDocument() throws -> Data {
        let url = Self.docDirURL.appendingPathComponent(fileName)
        do {
            return try Data(contentsOf: url)
        } catch {
            throw ErrorController.readError
        }
    }
    
    //saving image by product model uuid
    func saveImage(_ id: String, image: UIImage) throws {
        if let data = image.jpegData(compressionQuality: 0.6) {
            let imageURL = FileManager.docDirURL.appendingPathComponent("\(id).jpg")
            do {
                try data.write(to: imageURL)
            } catch {
                throw ErrorController.saveImageError
            }
        } else {
            throw ErrorController.saveImageError
        }
    }
    
    //load image by product model uuid
    func readImage(with id: UUID) throws -> UIImage {
        let imageURL = FileManager.docDirURL.appendingPathComponent("\(id).jpg")
        do {
            let imageData = try Data(contentsOf: imageURL)
            if let image = UIImage(data: imageData) {
                return image
            } else {
                throw ErrorController.readImageError
            }
        } catch {
            throw ErrorController.readImageError
        }
    }
}

