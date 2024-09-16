import Foundation

class LoginBuilder {
    static func build(coordinator: AuthCoordinator) -> LoginViewController {
        let emailValidator: EmailValidator = EmailValidatorAdapter()
            
        let httpClient: HTTPClientProtocol = HTTPClient()
        
        let viewModel = LoginViewModel(
            httpClient: httpClient,
            coordinator: coordinator,
            emailValidation: emailValidator
        )
        
        let viewController = LoginViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
