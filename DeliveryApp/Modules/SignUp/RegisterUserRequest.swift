//
//  RegisterUserRequest.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/01/24.
//

import Foundation

struct RegisterUserRequest: Model {
    let email: String
    let username: String
    let password: String
    let confirmPassword: String
}
