import Foundation
@testable import DeliveryApp

class AccountLoginSpy: LoginAccountUseCase {
    var httpResource: ((AuthRequest) -> ResourceModel)?
    
    private(set) var loginCredential: AuthRequest?
    private(set) var completion: ((Result<AuthResponse, LoginError>) -> Void)?
    
    func login(with credential: AuthRequest, completion: @escaping (Result<AuthResponse, LoginError>) -> Void) {
        self.loginCredential = credential
        self.completion = completion
    }
    
    func completeWithSuccess() {
        self.completion?(.success(AuthResponse(accessToken: "any_token")))
    }

    func completeWithFailure(loginError: LoginError) {
        self.completion?(.failure(loginError))
    }
}
