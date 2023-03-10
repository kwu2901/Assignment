//
//  File.swift
//  Assignment
//
//  Created by itst on 11/1/2023.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkHandler {
    let serverURL = "https://jsonbin.org/kwu2901/products"
    let token = "token 74bc5c8a-e465-49e3-8d77-9a3a5cc2287a"
    let headers: HTTPHeaders = [
        "authorization" : "token 74bc5c8a-e465-49e3-8d77-9a3a5cc2287a"
    ]
    
    //check network is connected
    func checkInt() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    //get server json data
    func GetRequest() {
        var url = URLRequest(url: URL(string: serverURL)!)
        url.httpMethod = HTTPMethod.get.rawValue
        url = try! URLEncoding.default.encode(url, with: nil)
        url.setValue(token, forHTTPHeaderField: "Authorization")
        
        
        AF.request(url).responseData { response in
            switch response.result {
            case .success (let value):
                let productList = JSON(value)
                print("\(productList)")
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //post server data
    func doRequest(product: [ProductModel], method: HTTPMethod){
        let params = convertToJson(products: product)
        
        AF.request(serverURL, method: method, parameters: params, headers: headers).responseJSON{ (respone) in
            switch respone.result {
            case .success:
                print(respone)
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    //setting request
    func setRequest(product: String) -> URLRequest{
        let url = URL(string: serverURL)!
        var request = URLRequest(url: url)
        
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        print(product)
        request.httpBody = (product).data(using: .unicode)
        return request
    }
    
    //convert productModel to Json
    func convertToJson(products: [ProductModel]) -> [String: Any] {
        var result = [String: Any]()
        for product in products{
            
            let json: [String: Any] = [
                "name":product.name,
                "dir":product.dir,
                "price":product.price,
                "isFav":product.isFav
            ]
            result.updateValue(json, forKey: product.id.uuidString)
            
        }
        return result
    }
}
