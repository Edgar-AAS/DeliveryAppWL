import Foundation
@testable import DeliveryApp

class AccountLoginSpy: LoginAccountUseCase {
    var loginResourceCallBack: ((LoginCredential) -> ResourceModel)?
    
    private(set) var loginCredential: LoginCredential?
    private(set) var completion: ((Result<AccountModelResponse, LoginError>) -> Void)?
    
    func login(with credential: LoginCredential, completion: @escaping (Result<AccountModelResponse, LoginError>) -> Void) {
        self.loginCredential = credential
        self.completion = completion
    }
    
    func completeWithSuccess() {
        self.completion?(.success(AccountModelResponse(accessToken: "any_token")))
    }

    func completeWithFailure(loginError: LoginError) {
        self.completion?(.failure(loginError))
    }
}
