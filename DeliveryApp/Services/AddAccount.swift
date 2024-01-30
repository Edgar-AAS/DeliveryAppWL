//
//  AuthService.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/01/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol AddAccountProtocol {
    func add(with userRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void)
}

class AddAccount: AddAccountProtocol {
    func add(with userRequest: RegisterUserRequest, completion: @escaping (Bool, Error?) -> Void) {
        Auth.auth().createUser(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(false, error)
                return
            }
            
            guard let resultUser = result?.user else {
                completion(false, nil)
                return
            }
            
            guard let data = userRequest.toJson() else { return }
            
            let database = Firestore.firestore()
            database.collection("users")
                .document(resultUser.uid)
                .setData(data) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                }
            completion(true, nil)
        }
    }
}
