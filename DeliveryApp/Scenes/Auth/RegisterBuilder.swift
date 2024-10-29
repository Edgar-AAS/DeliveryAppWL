import Foundation

class RegisterBuilder {
    static func build() -> RegisterViewController {
        let emailValidator: EmailValidaton = EmailValidator()
        let httpClient: HTTPClientProtocol = HTTPClient()
    
        let createAccountUseCase = CreateAccount(httpClient: httpClient)
        createAccountUseCase.registerAccountResource = { registerRequest in
            return Resource(
                url: URL(string: "http://localhost:5177/v1/accounts")!,
                method: .post(registerRequest.toData()),
                headers: ["Content-Type": "application/json"]
            )
        }
        
        let viewModel = RegisterViewModel(emailValidator: emailValidator, createAccount: createAccountUseCase)        
        let viewController = RegisterViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
