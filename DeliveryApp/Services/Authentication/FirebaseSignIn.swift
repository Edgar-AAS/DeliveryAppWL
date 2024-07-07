//
//  FirebaseSignIn.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 04/06/24.
//

import Foundation
import Firebase

protocol SignInProtocol {
    func signIn(loginRequest: LoginUserRequest, completion: @escaping (Bool, Error?) -> Void)
}

class FirebaseSignIn: SignInProtocol {
    func signIn(loginRequest: LoginUserRequest, completion: @escaping (Bool, Error?) -> Void) {
        func signIn(loginRequest: LoginUserRequest, completion: @escaping (Bool, Error?) -> Void) {
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
}
