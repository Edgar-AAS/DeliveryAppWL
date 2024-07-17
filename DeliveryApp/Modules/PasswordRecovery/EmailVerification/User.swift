//
//  User.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 06/06/24.
//

import Foundation

struct User: Equatable {
    var id: String?
    var accessToken: String?
    var fullName: String?
    var email: String?
    var dateOfBirth: String?
    var gender: String?
    var phone: String?
    var adresses: [UserAddress]?
    var avatar: String?
}

struct UserAddress: Equatable {
    var street: String
    var number: String
    var complement: String?
    var city: String
    var state: String
    var zipCode: String
    
    init(street: String,
         number: String,
         complement: String,
         city: String,
         state: String,
         zipCode: String)
    {
        self.street = street
        self.number = number
        self.complement = complement
        self.city = city
        self.state = state
        self.zipCode = zipCode
    }
}
