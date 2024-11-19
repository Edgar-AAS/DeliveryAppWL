import Foundation
@testable import DeliveryApp

class CreateAccountUseCaseSpy: CreateAccountUseCase {
    private(set) var userRequest: CreateAccountModel?
    private(set) var emit: ((Result<Void, HttpError>) -> Void)?
    
    func create(with request: CreateAccountModel, completion: @escaping (Result<Void, HttpError>) -> Void) {
        self.userRequest = request
        self.emit = completion
    }

    func completeWithSuccess() {
        self.emit?(.success(()))
    }

    func completeWithFailure(httpError: HttpError) {
        self.emit?(.failure(httpError))
    }
}
