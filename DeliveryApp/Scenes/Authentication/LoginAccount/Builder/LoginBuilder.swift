import Foundation

final class LoginBuilder {
    static func build() -> LoginViewController {
        let httpClient: HTTPClientProtocol = HTTPClient()
        let keychainService: KeychainService = KeychainManager()
        let userAccountLogin = LoginAccount(httpClient: httpClient, keychainService: keychainService)
        
        userAccountLogin.httpResource = { credential in
            return ResourceModel(
                url: URL(string: "http://localhost:5177/v1/account/login")!,
                method: .post(credential.toData()),
                headers: [
                    "Content-Type": "application/json",
            
                ]
            )
        }
        
        let emailValidator = EmailValidator()
    
        let validatorComposite = ValidationComposite(validations: [
            RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
            EmailValidation(fieldName: "email", fieldLabel: "Email", emailValidator: emailValidator),
            RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
            PasswordValidation(fieldName: "password", fieldLabel: "Senha")
        ])
        
        let viewModel = LoginViewModel(userAccountLogin: userAccountLogin,
                                       validatorComposite: validatorComposite)
        
        let viewController = LoginViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        return viewController
    }
}
