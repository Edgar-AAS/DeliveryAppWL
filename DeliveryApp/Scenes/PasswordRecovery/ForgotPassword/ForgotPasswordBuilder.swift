import Foundation

class ForgotPasswordBuilder {
    static func build(coordinator: MainCoordinator) -> ForgotPasswordViewController {
        let emailValidator = EmailValidatorAdapter()
        let viewModel = ForgotPasswordViewModel(emailValidator: emailValidator,
                                                coordinator: coordinator)
        let viewController = ForgotPasswordViewController(viewModel: viewModel)
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
