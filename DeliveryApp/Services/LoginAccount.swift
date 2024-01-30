//
//  LoginAccount.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/01/24.
//

import Foundation
import FirebaseAuth

protocol LoginAccountProtocol {
    func signInWith(loginRequest: LoginUserRequest, completion: @escaping (Bool, Error?) -> Void)
}

class LoginAccount: LoginAccountProtocol {
    func signInWith(loginRequest: LoginUserRequest, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().signIn(withEmail: loginRequest.email, password: loginRequest.password) { [weak self] authResult, error in
            guard self != nil else { return }
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
}
