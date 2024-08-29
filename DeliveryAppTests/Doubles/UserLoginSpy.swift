import Foundation
@testable import DeliveryApp

class UserLoginSpy: Authentication {
    private(set) var authenticationModel: LoginRequest?
    private(set) var emit: ((Result<Void, Error>) -> Void)?

    func auth(authenticationModel: LoginRequest, completion: @escaping (Result<Void, Error>) -> Void) {
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
