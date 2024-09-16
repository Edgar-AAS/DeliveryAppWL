import Foundation

class ForgotPasswordBuilder {
    static func build() -> ForgotPasswordViewController {
        let emailValidator = EmailValidatorAdapter()
        let viewModel = ForgotPasswordViewModel(emailValidator: emailValidator)
        let viewController = ForgotPasswordViewController(viewModel: viewModel)
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
