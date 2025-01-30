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
                    "Authorization": ""
                ]
            )
        }
        
        let emailValidator: EmailValidationProtocol = EmailValidator()
        let passwordValidator: PasswordValidationProtocol = PasswordValidator()
        
        let validatorComposite = ValidationComposite(validations: [
            RequiredFieldValidator(fieldName: "email", fieldLabel: "Email", fieldType: "email"),
            EmailFieldValidator(fieldName: "email", fieldLabel: "Email", emailValidator: emailValidator),
            RequiredFieldValidator(fieldName: "password", fieldLabel: "Senha", fieldType: "password"),
            PasswordStrongValidator(fieldName: "password", fieldType: "password", passwordValidator: passwordValidator)
        ])
        
        let viewModel = LoginViewModel(userAccountLogin: userAccountLogin,
                                       validatorComposite: validatorComposite)
        
        let viewController = LoginViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
