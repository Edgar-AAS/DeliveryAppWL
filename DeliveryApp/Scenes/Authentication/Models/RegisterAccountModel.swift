//
//  RegisterAccountModel.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 06/03/25.
//


import Foundation

struct RegisterAccountModel: Serializable {
    let email: String
    let username: String
    let password: String
    let confirmPassword: String
    
    init(email: String,
         username: String,
         password: String,
         confirmPassword: String) {
        
        self.email = email
        self.username = username
        self.password = password
        self.confirmPassword = confirmPassword
    }
}
