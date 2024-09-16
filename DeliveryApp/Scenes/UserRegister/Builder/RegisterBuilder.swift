import Foundation

class RegisterBuilder {
    static func build(coordinator: AuthCoordinator) -> RegisterViewController {
        let emailValidator: EmailValidator = EmailValidatorAdapter()
        let phoneNumberValidator: PhoneValidator = PhoneNumberValidator()
        let httpClient: HTTPClientProtocol = HTTPClient()
        let viewModel = RegisterViewModel(
            coordinator: coordinator,
            httpClient: httpClient,
            emailValidator: emailValidator,
            phoneValidator: phoneNumberValidator)
        let viewController = RegisterViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
