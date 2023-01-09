//
//  CameraModel.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import SwiftUI

class CameraModel: ObservableObject {
    @Published var image: UIImage?
    @Published var showPicker = false
    @Published var source: Picker.Source = .library
    @Published var imageName: String = ""
    @Published var isEditing = false
    @Published var selectedProduct: ProductModel?
    @Published var newImageList : [ProductModel] = []
    @Published var showFileAlert = false
    @Published var appError: ErrorController.ErrorType?
    
    func showPhotoPicker() {
        if source == .camera {
            if !Picker.checkPermissions() {
                print("There is no camera on this device")
                return
            }
        }
        showPicker = true
    }
    
    func addImageFunc(_ product: ProductModel, image: UIImage){
        //let myImage = ImageModel(name: name)
        do {
            try FileManager().saveImage("\(product.id)", image: image)
            newImageList.append(product)
            saveImageJSONFile()
            reset()
            
        } catch {
            showFileAlert = true
            appError = ErrorController.ErrorType(error: error as! ErrorController)
        }
    }
    
    func saveImageJSONFile() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(newImageList)
            let jsonString = String(decoding: data, as: UTF8.self)
            reset()
            do {
                try FileManager().saveDocument(contents: jsonString)
            } catch {
                showFileAlert = true
                appError = ErrorController.ErrorType(error: error as! ErrorController)
            }
        } catch {
            showFileAlert = true
            appError = ErrorController.ErrorType(error: .encodingError)
        }
    }
    
    func reset() {
        image = nil
        imageName = ""
        isEditing = false
        selectedProduct = nil
    }
    
    func loadMyImagesJSONFile() {
        do {
            let data = try FileManager().readDocument()
            let decoder = JSONDecoder()
            do {
                newImageList = try decoder.decode([ProductModel].self, from: data)
            } catch {
                showFileAlert = true
                appError = ErrorController.ErrorType(error: .decodingError)
            }
        } catch {
            showFileAlert = true
            appError = ErrorController.ErrorType(error: error as! ErrorController)
        }
    }
    
    func updateSelected(_ name: String, _ dir: String, _ price: Int) {
        if let index = newImageList.firstIndex(where: {$0.id == selectedProduct!.id}) {
            newImageList[index].name = name
            newImageList[index].dir = dir
            newImageList[index].price = price
            saveJSONFile()
            reset()
        }
    }
    
    func deleteSelected() {
        if let index = newImageList.firstIndex(where: {$0.id == selectedProduct!.id}) {
            newImageList.remove(at: index)
            saveJSONFile()
            reset()
        }
    }
    
    func display(_ product: ProductModel) {
        image = product.image
        imageName = product.name
        selectedProduct = product
    }
    
    func saveJSONFile() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(newImageList)
            let jsonString = String(decoding: data, as: UTF8.self)
            reset()
            do {
                try FileManager().saveDocument(contents: jsonString)
            } catch {
                showFileAlert = true
                appError = ErrorController.ErrorType(error: error as! ErrorController)
            }
        } catch {
            showFileAlert = true
            appError = ErrorController.ErrorType(error: .encodingError)
        }
    }
}



