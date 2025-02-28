import Foundation

final class LoginBuilder {
    static func build() -> LoginViewController {
        let httpClient: HTTPClientProtocol = HTTPClient()
        let userAccountLogin = LoginAccount(httpClient: httpClient)
        
        userAccountLogin.httpResource = { credential in
            return ResourceModel(
                url: URL(string: "http://localhost:5177/v1/account/login")!,
                method: .post(credential.toData()),
                headers: [
                    "Content-Type": "application/json",
            
                ]
            )
        }
    
        let validatorComposite = ValidationComposite(validations: [
            RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
            EmailValidation(fieldName: "email", fieldLabel: "Email"),
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
