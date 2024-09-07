import Foundation

class RegisterBuilder {
    static func build(coordinator: Coordinator) -> RegisterViewController {
        let emailValidator = EmailValidatorAdapter()
        let viewModel = RegisterViewModel(emailValidator: emailValidator, coordinator: coordinator)
    
        let viewController = RegisterViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
