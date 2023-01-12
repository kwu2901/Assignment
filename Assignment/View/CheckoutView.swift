//
//  CheckoutView.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import SwiftUI
import CoreLocation
import CoreLocationUI

struct CheckoutView: View {
    @ObservedObject var locationManager = LocationManager()
    @EnvironmentObject var cartManager: CartManager
    @State var name: String = ""
    @State var address: String = ""
    @State var city: String = ""
    @State var zipCode: String = ""
    
    var body: some View {
        NavigationView{
            VStack{
                Form{
                    
                    Section(header: Text("Name")){
                        TextField("Name", text: $name)
                    }
                    Section(header: Text("Address")){
                        TextField("Address Detail", text: $address)
                        TextField("City", text: $city)
                        TextField("Zip Code", text: $zipCode)
                        Button("Auto Fill Your Location"){
                            autoFillIn()
                        }
                    }
                    
                    
                }
                .navigationTitle("Dlivery Details")
                .navigationBarTitleDisplayMode(.inline)
                HStack{
                    PaymentButton(action: {cartManager.pay()})
                        .padding()
                }
            }
            .navigationViewStyle(.stack)
        }
    }
    
    //call location manager to fill in GPS local
    func autoFillIn(){
        let latitude = locationManager.lastLocation?.coordinate.latitude ?? 0
        let longitude = locationManager.lastLocation?.coordinate.longitude ?? 0
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location) {
            placemarks, error in
            guard let placemark = placemarks?.first else {
                let errorString = error?.localizedDescription ?? "Unexpected Error"
                print("Unable to reverse geocode the given location. Error: \(errorString)")
                return
            }
            let locationModel = LocationModel(with: placemark)
            address = locationModel.name
            city = locationModel.city
            zipCode = locationModel.zipCode
        }
    }
}


struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(CartManager())
    }
}

