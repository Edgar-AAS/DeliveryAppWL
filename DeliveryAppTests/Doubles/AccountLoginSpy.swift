import Foundation
@testable import DeliveryApp

class AccountLoginSpy: LoginAccountUseCase {
    var loginResourceCallBack: ((LoginAccountCredentialDTO) -> ResourceModel)?
    
    private(set) var loginCredential: LoginAccountCredentialDTO?
    private(set) var completion: ((Result<LoginAccountResponseDTO, LoginError>) -> Void)?
    
    func login(with credential: LoginAccountCredentialDTO, completion: @escaping (Result<LoginAccountResponseDTO, LoginError>) -> Void) {
        self.loginCredential = credential
        self.completion = completion
    }
    
    func completeWithSuccess() {
        self.completion?(.success(LoginAccountResponseDTO(accessToken: "any_token")))
    }

    func completeWithFailure(loginError: LoginError) {
        self.completion?(.failure(loginError))
    }
}
