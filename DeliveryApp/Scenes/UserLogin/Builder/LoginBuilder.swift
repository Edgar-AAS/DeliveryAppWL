import Foundation

class LoginBuilder {
    static func build(coordinator: MainCoordinator) -> LoginViewController {
        let userLogin: Authentication = FirebaseLogin()
        let emailValidator: EmailValidator = EmailValidatorAdapter()
        
        let viewModel = LoginViewModel(
            coordinator: coordinator,
            authentication: userLogin,
            emailValidation: emailValidator
        )
        
        let viewController = LoginViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
