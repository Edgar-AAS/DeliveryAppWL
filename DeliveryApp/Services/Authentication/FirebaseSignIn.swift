//
//  FirebaseSignIn.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 04/06/24.
//

import Foundation
import Firebase

protocol LoginProtocol {
    func auth(authenticationModel: AuthenticationModel, completion: @escaping (Result<Void, Error>) -> Void)
}

class FirebaseSignIn: LoginProtocol {
    func auth(authenticationModel: AuthenticationModel, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: authenticationModel.email, password: authenticationModel.password) { [weak self] authResult, error in
            guard self != nil else { return }
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
