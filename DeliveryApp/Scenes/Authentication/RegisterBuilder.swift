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
        
        let validatorComposite = ValidationComposite(validations: [
            RequiredFieldValidation(fieldName: "email", fieldLabel: "Email"),
            EmailValidation(fieldName: "email", fieldLabel: "Email"),
            RequiredFieldValidation(fieldName: "username", fieldLabel: "Nome de Usuário"),
            RequiredFieldValidation(fieldName: "password", fieldLabel: "Senha"),
            PasswordValidation(fieldName: "password", fieldLabel: "Senha"),
            RequiredFieldValidation(fieldName: "confirmPassword", fieldLabel: "Confirmação de Senha"),
            PasswordValidation(fieldName: "confirmPassword", fieldLabel: "Confirmação de Senha"),
            CompareFieldsValidation(fieldName: "confirmPassword", fieldLabel: "Confirmação de Senha", fieldNameToCompare: "password")
        ])
        
        let viewModel = RegisterViewModel(validatorComposite: validatorComposite, createAccount: createAccountUseCase)
        let viewController = RegisterViewController(viewModel: viewModel)
        
        viewModel.alertView = viewController
        return viewController
    }
}
