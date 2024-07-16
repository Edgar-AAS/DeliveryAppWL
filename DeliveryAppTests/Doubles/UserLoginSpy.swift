//
//  UserLoginSpy.swift
//  DeliveryAppTests
//
//  Created by Edgar Arlindo on 16/07/24.
//

import Foundation
@testable import DeliveryApp

class UserLoginSpy: LoginProtocol {
    private(set) var authenticationModel: AuthenticationModel?
    private(set) var emit: ((Result<Void, Error>) -> Void)?

    func auth(authenticationModel: DeliveryApp.AuthenticationModel, completion: @escaping (Result<Void, Error>) -> Void) {
        self.authenticationModel = authenticationModel
        self.emit = completion
    }
    
    func completeWithSuccess() {
        self.emit?(.success(()))
    }

    func completeWithFailure() {
        self.emit?(.failure(NSError(domain: "", code: 0)))
    }
}
