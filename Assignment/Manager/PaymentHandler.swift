//
//  PaymentHandler.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import Foundation
import PassKit

typealias PaymentCompletionHandler = (Bool) -> Void

class PaymentHandler: NSObject {
    var paymentController: PKPaymentAuthorizationController?
    var paymentSummaryItems = [PKPaymentSummaryItem]()
    var paymentStatus = PKPaymentAuthorizationStatus.failure
    var completionHandler: PaymentCompletionHandler?
    
    //payment network
    static let supportedNetwork: [PKPaymentNetwork] = [
        .visa,
        .masterCard
    ]
    
    //Delivery setting
    func shippingMethodCalculator() -> [PKShippingMethod] {
        let today = Date()
        let calender = Calendar.current
        let shippingStart = calender.date(byAdding: .day, value: 5, to: today)
        let shippingEnd = calender.date(byAdding: .day, value: 10, to: today)
        
        if let shippingEnd = shippingEnd, let shippingStart = shippingStart {
            let startComponents = calender.dateComponents([.calendar, .year, .month, .day], from: shippingStart)
            let endComponents = calender.dateComponents([.calendar, .year, .month, .day], from: shippingEnd)
            
            let shippingDalivery = PKShippingMethod(label: "Delivery", amount: NSDecimalNumber(string: "0.00"))
            shippingDalivery.dateComponentsRange = PKDateComponentsRange(start: startComponents, end: endComponents)
            shippingDalivery.detail = "Sweaters sent to your address"
            shippingDalivery.identifier = "DELIVERY"
            
            return [shippingDalivery]
        }
        return []
    }
    
    //create apple pay requset
    func startPayment(products: [ProductModel], total: Int, completion: @escaping PaymentCompletionHandler){
        completionHandler = completion
        
        paymentSummaryItems = []
        
        products.forEach { product in
            let item = PKPaymentSummaryItem(label: product.name, amount: NSDecimalNumber(string: "\(product.price).00"), type: .final)
            paymentSummaryItems.append(item)
        }
        
        let totel = PKPaymentSummaryItem(label: "Total", amount: NSDecimalNumber(string: "\(total).00"), type: .final)
        paymentSummaryItems.append(totel)
        
        let paymentRequest = PKPaymentRequest()
        paymentRequest.paymentSummaryItems = paymentSummaryItems
        paymentRequest.merchantIdentifier = "edu.self.Assignment-227105563"
        paymentRequest.merchantCapabilities = .capability3DS
        paymentRequest.countryCode = "HK"
        paymentRequest.currencyCode = "HKD"
        paymentRequest.supportedNetworks = PaymentHandler.supportedNetwork
        paymentRequest.shippingType = .delivery
        paymentRequest.shippingMethods = shippingMethodCalculator()
        paymentRequest.requiredShippingContactFields = [.name, .postalAddress]
        
        paymentController = PKPaymentAuthorizationController(paymentRequest: paymentRequest)
        paymentController?.delegate = self
        paymentController?.present(completion: { (presented: Bool) in
            if presented {
                debugPrint("Presented payment controllar")
            }else{
                debugPrint("Filed to present controller")
            }
        })
    }
}
    
extension PaymentHandler: PKPaymentAuthorizationControllerDelegate{
    //handler pay statues is success or not
    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        let errors = [Error]()
        let status = PKPaymentAuthorizationStatus.success
        
        self.paymentStatus = status
        completion(PKPaymentAuthorizationResult(status: status, errors: errors))
    }
    
    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss {
            DispatchQueue.main.async {
                if self.paymentStatus == .success {
                    if let completionHandler = self.completionHandler {
                        completionHandler (true)
                    }
                } else {
                    if let completionHandler = self.completionHandler {
                        completionHandler (false)
                    }
                }
            }
        }
    }
}



