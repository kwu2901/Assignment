//
//  UserModel.swift
//  Assignment
//
//  Created by itst on 6/1/2023.
//

import SwiftUI

struct UserModel: Identifiable{
    var id = UUID()
    var root: String
    
}

extension UserModel{
    static var user = UserModel(root: "C")
}
