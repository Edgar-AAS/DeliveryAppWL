//
//  FirebaseResetPassword.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 04/06/24.
//

import Foundation
import Firebase

protocol PasswordResetProtocol {
    func sendPasswordResetWith(userRequest: ForgotPasswordUserRequest, completion: @escaping (Bool, Error?) -> Void)
}

class FirebasePasswordReset: PasswordResetProtocol {
    func sendPasswordResetWith(userRequest: ForgotPasswordUserRequest, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: userRequest.email) { error in
            if let error = error {
                completion(false, error)
            } else {
                completion(true, nil)
            }
        }
    }
}
