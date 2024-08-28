import Foundation
import Firebase

protocol Authentication {
    func auth(authenticationModel: LoginRequest, completion: @escaping (Result<Void, Error>) -> Void)
}

class FirebaseLogin: Authentication {
    func auth(authenticationModel: LoginRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: authenticationModel.email, password: authenticationModel.password) { [weak self] authResult, error in
            guard self != nil else { return }
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}

