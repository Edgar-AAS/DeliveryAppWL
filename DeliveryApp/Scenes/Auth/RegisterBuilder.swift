import Foundation

class RegisterBuilder {
    static func build() -> RegisterViewController {
        let httpClient: HTTPClientProtocol = HTTPClient()
    
        let createAccountUseCase = CreateAccount(httpClient: httpClient)
        createAccountUseCase.registerAccountResource = { registerRequest in
            return Resource(
                url: URL(string: "http://localhost:5177/v1/accounts")!,
                method: .post(registerRequest.toData()),
                headers: ["Content-Type": "application/json"]
            )
        }
        
        let emailValidator = EmailValidatorAdapter()
        
        let validatorComposite = ValidationComposite(validations: [
            RequiredFieldValidator(fieldName: "email", fieldLabel: "Email", fieldType: .email),
            EmailFieldValidator(fieldName: "email", fieldLabel: "Email", fieldType: .email, emailValidator: emailValidator),
            RequiredFieldValidator(fieldName: "username", fieldLabel: "Nome de Usuário", fieldType: .regular),
            RequiredFieldValidator(fieldName: "password", fieldLabel: "Senha", fieldType: .password),
            RequiredFieldValidator(fieldName: "confirmPassword", fieldLabel: "Confirmação de Senha", fieldType: .passwordConfirm),
            CompareFieldsValidator(fieldName: "confirmPassword", fieldLabel: "Senha", fieldNameToCompare: "password", fieldLabelToCompare: "Confirmação de Senha", fieldType: .passwordConfirm)
        ])
        
        let viewModel = RegisterViewModel(validatorComposite: validatorComposite, createAccount: createAccountUseCase)
        let viewController = RegisterViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
