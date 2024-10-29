import Foundation
@testable import DeliveryApp

class AccountLoginSpy: AccountLoginUseCase {
    private(set) var loginCredential: LoginCredential?
    private(set) var emit: ((Result<AccountModelResponse, HttpError>) -> Void)?

    func login(with credential: LoginCredential, completion: @escaping (Result<AccountModelResponse, HttpError>) -> Void) {
        self.loginCredential = credential
        self.emit = completion
    }
    
    func completeWithSuccess() {
        self.emit?(.success(AccountModelResponse(accessToken: "any_token")))
    }

    func completeWithFailure(httpError: HttpError) {
        self.emit?(.failure(httpError))
    }
}
