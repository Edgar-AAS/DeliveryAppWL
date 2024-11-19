import Foundation

final class RegisterBuilder {
    static func build() -> RegisterViewController {
        let httpClient: HTTPClientProtocol = HTTPClient()
    
        let createAccountUseCase = CreateAccount(httpClient: httpClient)
        createAccountUseCase.registerAccountResource = { registerRequest in
            return ResourceModel(
                url: URL(string: "http://localhost:5177/v1/accounts")!,
                method: .post(registerRequest.toData()),
                headers: ["Content-Type": "application/json"]
            )
        }
        
        let emailValidator: EmailValidationProtocol = EmailValidator()
        
        let validatorComposite = ValidationComposite(validations: [
            RequiredFieldValidator(fieldName: "email", fieldLabel: "Email"),
            EmailFieldValidator(fieldName: "email", fieldLabel: "Email", emailValidator: emailValidator),
            RequiredFieldValidator(fieldName: "username", fieldLabel: "Nome de Usuário"),
            RequiredFieldValidator(fieldName: "password", fieldLabel: "Senha"),
            RequiredFieldValidator(fieldName: "confirmPassword", fieldLabel: "Confirmação de Senha"),
            CompareFieldsValidator(fieldName: "confirmPassword", fieldLabel: "Confirmação de Senha", fieldNameToCompare: "password")
        ])
        
        let viewModel = RegisterViewModel(validatorComposite: validatorComposite, createAccount: createAccountUseCase)
        let viewController = RegisterViewController(viewModel: viewModel)
        
        viewModel.alertView = viewController
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
