import Foundation
@testable import DeliveryApp

class UserRegisterSpy: RegisterProtocol {
    private(set) var userRequest: RegisterUserRequest?
    private(set) var emit: ((Result<Void, Error>) -> Void)?
    
    func register(userRequest: RegisterUserRequest, completion: @escaping (Result<Void, Error>) -> Void) {
        self.userRequest = userRequest
        self.emit = completion
    }
    
    func completeWithSuccess() {
        self.emit?(.success(()))
    }

    func completeWithFailure() {
        self.emit?(.failure(NSError(domain: "", code: 0)))
    }
}
