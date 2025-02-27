import Foundation

final class RegisterBuilder {
    static func build() -> RegisterViewController {
        let httpClient: HTTPClientProtocol = HTTPClient()
    
        let createAccountUseCase = RegisterAccount(httpClient: httpClient)
        createAccountUseCase.registerAccountResource = { registerRequest in
            return ResourceModel(
                url: URL(string: "http://localhost:5177/v1/account/create")!,
                method: .post(registerRequest.toData()),
                headers: ["Content-Type": "application/json"]
            )
        }
        
        let emailValidator: EmailValidationProtocol = EmailValidator()
        let passwordValidator: PasswordValidationProtocol = PasswordValidator()
        
        let validatorComposite = ValidationComposite(validations: [
            RequiredFieldValidator(fieldName: "email", fieldLabel: "Email", fieldType: "email"),
            EmailFieldValidator(fieldName: "email", fieldLabel: "Email", emailValidator: emailValidator),
            RequiredFieldValidator(fieldName: "username", fieldLabel: "Nome de Usuário", fieldType: "regular"),
            RequiredFieldValidator(fieldName: "password", fieldLabel: "Senha", fieldType: "password"),
            PasswordStrongValidator(fieldName: "password", fieldType: "password", passwordValidator: passwordValidator),
            RequiredFieldValidator(fieldName: "confirmPassword", fieldLabel: "Confirmação de Senha", fieldType: "passwordConfirm"),
            PasswordStrongValidator(fieldName: "confirmPassword", fieldType: "passwordConfirm", passwordValidator: passwordValidator),
            CompareFieldsValidator(fieldName: "confirmPassword", fieldType: "passwordConfirm", fieldLabel: "Confirmação de Senha", fieldNameToCompare: "password")
        ])
        
        let viewModel = RegisterViewModel(validatorComposite: validatorComposite, createAccount: createAccountUseCase)
        let viewController = RegisterViewController(viewModel: viewModel)
        
        viewModel.alertView = viewController
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
