import Foundation

class LoginViewModel: LoginViewModelProtocol {
    //MARK: - Properties
    var loadingHandler: ((LoadingState) -> ())?
    var onLoginSuccess: (() -> Void)?
    
    private let emailValidator: EmailValidaton
    private let userAccountLogin: AccountLoginUseCase
    
    weak var fieldValidationDelegate: FieldValidationDelegate?
    weak var alertView: AlertView?
    
    //MARK: - Initializers
    init(userAccountLogin: AccountLoginUseCase, emailValidation: EmailValidaton) {
        self.userAccountLogin = userAccountLogin
        self.emailValidator = emailValidation
    }
    
    //MARK: - signIn
    func signIn(credential: LoginCredential) {
        if let fieldValidationViewModel = validateFields(loginRequest: credential) {
            fieldValidationDelegate?.showMessage(viewModel: fieldValidationViewModel)
        } else {
            loadingHandler?(LoadingState(isLoading: true))
            
            userAccountLogin.login(with: credential) { [weak self] result in
                switch result {
                case .success(_):
                    self?.loadingHandler?(LoadingState(isLoading: false))
                    self?.onLoginSuccess?()
                case .failure(let httpError):
                    self?.loadingHandler?(LoadingState(isLoading: false))
                    switch httpError {
                    case .badRequest:
                        self?.alertView?.showMessage(
                            viewModel: AlertViewModel(title: "Falha na validação",
                                                      message: "Email e/ou senha inválida.")
                        )
                    default:
                        self?.alertView?.showMessage(viewModel: AlertViewModel(
                            title: "Erro",
                            message: "Algo inesperado aconteceu, tente novamente em instantes."))
                    }
                }
            }
        }
    }
}

//MARK: - validateFields
extension LoginViewModel {
    private func validateFields(loginRequest: LoginCredential) -> FieldValidationViewModel? {
        if let emailError = validateEmail(loginRequest.email) {
            return emailError
        }
        
        if loginRequest.password.isEmpty {
            return FieldValidationViewModel(message: Strings.FieldValidationMessages.passwordEmpty, type: .password)
        }
        return nil
    }
    
    private func validateEmail(_ email: String) -> FieldValidationViewModel? {
        if email.isEmpty {
            return FieldValidationViewModel(message: Strings.FieldValidationMessages.emailEmpty, type: .email)
        } else if !emailValidator.isValid(email: email) {
            return FieldValidationViewModel(message: Strings.FieldValidationMessages.emailInvalid, type: .email)
        }
        return nil
    }
}
