import Foundation

class LoginBuilder {
    static func build() -> LoginViewController {
        let emailValidator: EmailValidaton = EmailValidator()
        let httpClient: HTTPClientProtocol = HTTPClient()
        
        let viewModel = LoginViewModel(
            httpClient: httpClient,
            emailValidation: emailValidator
        )
        
        let viewController = LoginViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
