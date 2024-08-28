import Foundation

class ForgotPasswordBuilder {
    static func build(coordinator: MainCoordinator) -> ForgotPasswordViewController {
        let emailValidator = EmailValidatorAdapter()
        let passwordReset = FirebasePasswordReset()
        let viewModel = ForgotPasswordViewModel(passwordReset: passwordReset,
                                                emailValidator: emailValidator,
                                                coordinator: coordinator)
        let viewController = ForgotPasswordViewController(viewModel: viewModel)
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
