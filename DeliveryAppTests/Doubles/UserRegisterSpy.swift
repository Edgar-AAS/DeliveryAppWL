import Foundation
@testable import DeliveryApp

class CreateAccountUseCaseSpy: CreateAccountUseCase {
    var registerAccountResource: ((CreateAccountModel) -> ResourceModel)?
    
    private(set) var userRequest: CreateAccountModel?
    private(set) var emit: ((Result<Void, RegisterError>) -> Void)?
    
    func create(with request: CreateAccountModel, completion: @escaping (Result<Void, RegisterError>) -> Void) {
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
