import Foundation

class RegisterBuilder {
    static func build() -> RegisterViewController {
        let emailValidator: EmailValidator = EmailValidatorAdapter()
        let phoneNumberValidator: PhoneValidator = PhoneNumberValidator()
        let httpClient: HTTPClientProtocol = HTTPClient()
       
        let viewModel = RegisterViewModel(
            httpClient: httpClient,
            emailValidator: emailValidator,
            phoneValidator: phoneNumberValidator)
        
        let viewController = RegisterViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
