//
//  TestsFactories.swift
//  DeliveryAppTests
//
//  Created by Edgar Arlindo on 15/07/24.
//

import Foundation
@testable import DeliveryApp

func makeAuthenticationModel(email: String, password: String) -> AuthenticationModel {
    return AuthenticationModel(email: email, password: password)
}
