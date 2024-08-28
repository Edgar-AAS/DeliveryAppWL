import Foundation
import FirebaseAuth
import Firebase

protocol RegisterProtocol {
    func register(userRequest: RegisterUserRequest, completion: @escaping (Result<Void, Error>) -> Void)
}

class FirebaseRegister: RegisterProtocol {
    func register(userRequest: RegisterUserRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: userRequest.email, password: userRequest.password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let resultUser = result?.user else {
                return
            }
            
            guard let data = userRequest.toJson() else { return }
            
            let database = Firestore.firestore()
            database.collection("users")
                .document(resultUser.uid)
                .setData(data) { error in
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                }
            completion(.success(()))
        }
    }
}
