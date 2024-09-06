import Foundation

class LoginViewModel: LoginViewModelProtocol {
//MARK: - Properties
    private let coordinator: Coordinator
    private let authentication: Authentication
    private let emailValidation: EmailValidator
    var loadingHandler: ((Bool) -> ())?
    
    weak var fieldValidationDelegate: FieldValidationDelegate?
    weak var alertView: AlertView?

//MARK: - Initializers
    init(coordinator: Coordinator,
         authentication: Authentication,
         emailValidation: EmailValidator
    )
    
    {
        self.coordinator = coordinator
        self.authentication = authentication
        self.emailValidation = emailValidation
    }
    
//MARK: - signIn
    func signIn(loginRequest: LoginRequest) {
        if let fieldValidationViewModel = validateFields(loginRequest: loginRequest) {
            fieldValidationDelegate?.showMessage(viewModel: fieldValidationViewModel)
        } else {
            loadingHandler?(true)
            authentication.auth(authenticationModel: loginRequest) { [weak self] result in
                DispatchQueue.main.async { [weak self] in
                    switch result {
                    case .success():
                        self?.loadingHandler?(false)
                        self?.coordinator.eventOcurred(type: .goToHome)
                    case .failure:
                        let alertViewModel = AlertViewModel(
                            title: AlertViewMessages.errorTitle,
                            message: AlertViewMessages.errorMessage
                        )
                        self?.alertView?.showMessage(viewModel: alertViewModel)
                        self?.loadingHandler?(false)
                    }
                }
            }
        }
    }
    
//MARK: - goToForgotPassword
    func goToForgotPassword() {
        coordinator.eventOcurred(type: .goToForgotPassword)
    }
    
//MARK: - goToHome
    func goToHome() {
        coordinator.eventOcurred(type: .goToHome)
    }
    
//MARK: - goToSignUp
    func goToSignUp() {
        coordinator.eventOcurred(type: .loginToRegister)
    }
}

//MARK: - validateFields
extension LoginViewModel {
    private func validateFields(loginRequest: LoginRequest) -> FieldValidationViewModel? {
        if let emailError = validateEmail(loginRequest.email) {
            return emailError
        }
        
        if loginRequest.password.isEmpty {
            return FieldValidationViewModel(message: FieldValidationMessages.passwordEmpty, type: .password)
        }
        return nil
    }
    
    private func validateEmail(_ email: String) -> FieldValidationViewModel? {
        if email.isEmpty {
            return FieldValidationViewModel(message: FieldValidationMessages.emailEmpty, type: .email)
        } else if !emailValidation.isValid(email: email) {
            return FieldValidationViewModel(message: FieldValidationMessages.emailInvalid, type: .email)
        }
        return nil
    }
}
