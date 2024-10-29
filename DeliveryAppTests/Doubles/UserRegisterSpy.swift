import Foundation
@testable import DeliveryApp

class CreateAccountUseCaseSpy: CreateAccountUseCase {
    private(set) var userRequest: CreateAccountModel?
    private(set) var emit: ((Result<CreateAccountStatusResponse, HttpError>) -> Void)?
    
    func create(with request: CreateAccountModel, completion: @escaping (Result<CreateAccountStatusResponse, HttpError>) -> Void) {
        self.userRequest = request
        self.emit = completion
    }

    func completeWithSuccess(reponse: CreateAccountStatusResponse) {
        self.emit?(.success(reponse))
    }

    func completeWithFailure(httpError: HttpError) {
        self.emit?(.failure(httpError))
    }
}
