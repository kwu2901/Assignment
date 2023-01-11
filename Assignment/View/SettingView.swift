//
//  SettingView.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import SwiftUI

struct SettingView: View {
    @StateObject var model = BiometricModel()
    @State private var loginSucc = false
    @Binding var root: String
    
    var body: some View {
        NavigationView {
            VStack {
                
                Image(systemName: "faceid")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                if model.isError == true {
                    Text("\(model.errorMessage)")
                }
                Button(action: {
                    model.evaluatePolicy()
                    loginSucc = model.isAuthenicated
                    if loginSucc == true {
                        root = "Admin"
                    }
                }, label: {
                    if loginSucc == true {
                        Text(root)
                    }else {
                        Text("Click to Login")
                    }
                })
                
            }
            .padding()
            .onAppear {
                model.checkPolicy()
            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(root: .constant("Client"))
    }
}
