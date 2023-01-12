//
//  NewProductView.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import SwiftUI

struct NewProductView: View {
    @EnvironmentObject var cameraModel: CameraModel
    @EnvironmentObject var productManager: ProductManager
    @State private var name: String = ""
    @State private var dir:  String = ""
    @State private var price: String = ""
    @State private var toProductView = false
    
    var body: some View {
        NavigationView{
            VStack{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(productManager.products) { products in
                            VStack {
                                Image(uiImage: products.image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 100)
                                    .clipShape(RoundedRectangle(cornerRadius: 15))
                                    .shadow(color: .black.opacity(0.6), radius: 2, x: 2, y: 2)
                                Text(products.name)
                            }
                            .onTapGesture {
                                cameraModel.display(products)
                                name = products.name
                                dir = products.dir
                                price = "\(products.price)"
                            }
                        }
                    }
                }.padding(.horizontal)
                if let image = cameraModel.image{
                    ZoomableScrollView{
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                }else{
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .opacity(0.6)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding(.horizontal)
                    
                }
                
                HStack{
                    Button{
                        cameraModel.source = .camera
                        cameraModel.showPicker = true
                    }label: {
                        HStack{
                            Image(systemName: "camera")
                            Text("Camera")
                        }
                        .font(.headline)
                        .padding()
                        .frame(height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    }
                    Button{
                        cameraModel.source = .library
                        cameraModel.showPicker = true
                    }label: {
                        HStack{
                            Image(systemName: "photo")
                            Text("Photos")
                        }
                        .font(.headline)
                        .padding()
                        .frame(height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    }
                }
                
                HStack{
                    Button{
                        cameraModel.deleteSelected()
                        reset()
                        productManager.loadMyImagesJSONFile()
                    }label: {
                        HStack{
                            Image(systemName: "trash")
                            Text("Delete")
                        }
                        .font(.headline)
                        .padding()
                        .frame(height: 40)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                    }
                    .disabled(cameraModel.selectedProduct == nil)
                    .opacity(cameraModel.selectedProduct == nil ? 0.6 : 1)
                }
                
                Form{
                    Section(header: Text("Product Name")){
                        TextField("name", text: $name) {
                            isEditing in
                            cameraModel.isEditing = isEditing
                        }
                    }
                    Section(header: Text("Description")){
                        TextField("description", text: $dir)
                    }
                    Section(header: Text("Price")){
                        TextField("$", text: $price)
                    }
                    
                }
                
                .toolbar(content: {
                    ToolbarItem(placement: .navigationBarLeading){
                        Button{
                            cameraModel.reset()
                            reset()
                        }label: {
                            Label("Cancel", systemImage: "xmark")
                                .labelStyle(.iconOnly)
                        }
                        
                    }
                    ToolbarItem(){
                        Button{
                            if cameraModel.selectedProduct == nil {
                                cameraModel.addImageFunc(saveNewProduct(), image: cameraModel.image!)
                                reset()
                            } else {
                                cameraModel.updateSelected(name, dir, Int(price)!)
                                reset()
                                productManager.loadMyImagesJSONFile()
                            }
                        }label: {
                            Label("Done", systemImage: "checkmark")
                                .labelStyle(.iconOnly)
                        }
                        .disabled(name.isEmpty)
                        .disabled(!price.isInt)
                        .disabled(cameraModel.image == nil)
                    }
                })
                .navigationTitle("New Product")
                .navigationBarTitleDisplayMode(.inline)
                .task {
                    if FileManager().docExist(named: fileName) {
                        cameraModel.loadMyImagesJSONFile()
                    }
                }
                .sheet(isPresented: $cameraModel.showPicker){
                    ImagePicker(sourceType: cameraModel.source == .library ? .photoLibrary : .camera, selectedImage: $cameraModel.image)
                        .ignoresSafeArea()
                }
            }
        }
        .navigationViewStyle(.stack)
    }
}

//check int of price
extension String{
    var isInt: Bool {
        return Int(self) != nil
    }
}

struct NewProductView_Previews: PreviewProvider {
    static var previews: some View {
        NewProductView()
            .environmentObject(CameraModel())
            .environmentObject(ProductManager())
    }
}

//reset view value
extension NewProductView{
    private func reset(){
        name = ""
        dir = ""
        price = ""
    }
}

//call product manager to save new obj
extension NewProductView{
    func saveNewProduct() -> ProductModel{
        let newProduct = ProductModel(name: name, dir: dir, price: Int(price)!, isFav: false)
        productManager.addToProductList(product: newProduct)
        return(newProduct)
    }
}
