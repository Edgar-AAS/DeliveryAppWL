import Foundation
@testable import DeliveryApp

final class LoginAccountUseCaseSpy: LoginAccountUseCase {
    var httpResource: ((LoginAccountRequest) -> ResourceModel)?
    
    private(set) var loginCredential: LoginAccountRequest?
    private(set) var completion: ((Result<LoginAccountResponse, LoginAccountError>) -> Void)?
    
    func login(with credential: LoginAccountRequest, completion: @escaping (Result<LoginAccountResponse, LoginAccountError>) -> Void) {
        self.loginCredential = credential
        self.completion = completion
    }
    
    func completeWithSuccess() {
        self.completion?(.success(LoginAccountResponse(accessToken: "any_token", userId: 0)))
    }

    func completeWithFailure(loginError: LoginAccountError) {
        self.completion?(.failure(loginError))
    }
}
