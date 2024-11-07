import Foundation

class LoginBuilder {
    static func build() -> LoginViewController {
        let httpClient: HTTPClientProtocol = HTTPClient()
        let userAccountLogin = UserAccountLogin(httpClient: httpClient)
        
        userAccountLogin.loginResourceCallBack = { credential in
            return Resource(url: URL(string: "http://localhost:5177/v1/accounts/login")!,
                                    method: .post(credential.toData()),
                                    headers: ["Content-Type": "application/json"])
        }
        
        
        let emailValidator = EmailValidator()
        
        let validatorComposite = ValidationComposite(validations: [
            RequiredFieldValidator(fieldName: "email", fieldLabel: "Email", fieldType: .email),
            EmailFieldValidator(fieldName: "email", fieldLabel: "Email", fieldType: .email, emailValidator: emailValidator),
            RequiredFieldValidator(fieldName: "password", fieldLabel: "Senha", fieldType: .password)
        ])
        
        let viewModel = LoginViewModel(
            userAccountLogin: userAccountLogin,
            validatorComposite: validatorComposite)
        
        let viewController = LoginViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
