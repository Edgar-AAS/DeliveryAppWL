//
//  RegisterAccountRequest.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 06/03/25.
//


import Foundation

struct RegisterAccountRequest: Serializable {
    let name: String
    let email: String
    let password: String
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
}
