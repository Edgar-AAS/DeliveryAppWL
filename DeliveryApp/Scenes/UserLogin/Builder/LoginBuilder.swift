import Foundation

class LoginBuilder {
    static func build(coordinator: MainCoordinator) -> LoginViewController {
        let emailValidator: EmailValidator = EmailValidatorAdapter()
        
        let viewModel = LoginViewModel(
            coordinator: coordinator,
            emailValidation: emailValidator
        )
        
        let viewController = LoginViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
