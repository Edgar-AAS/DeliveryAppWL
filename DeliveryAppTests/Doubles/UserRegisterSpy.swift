import Foundation
@testable import DeliveryApp

class CreateAccountUseCaseSpy: RegisterAccountUseCase {
    var registerAccountResource: ((RegisterAccountRequest) -> ResourceModel)?
    
    private(set) var userRequest: RegisterAccountRequest?
    private(set) var emit: ((Result<Void, RegisterError>) -> Void)?
    
    func register(with request: RegisterAccountRequest, completion: @escaping (Result<Void, RegisterError>) -> Void) {
        self.userRequest = request
        self.emit = completion
    }

    func completeWithSuccess() {
        self.emit?(.success(()))
    }

    func completeWithFailure(registerError: RegisterError) {
        self.emit?(.failure(registerError))
    }
}
