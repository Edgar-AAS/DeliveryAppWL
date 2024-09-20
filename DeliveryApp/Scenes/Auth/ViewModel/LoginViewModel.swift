import Foundation

class LoginViewModel: LoginViewModelProtocol {
    //MARK: - Properties
    var loadingHandler: ((Bool) -> ())?
    var onLoginSuccess: (() -> Void)?
    
    private let httpClient: HTTPClientProtocol
    private let emailValidation: EmailValidator

    weak var fieldValidationDelegate: FieldValidationDelegate?
    weak var alertView: AlertView?
    
    //MARK: - Initializers
    init(httpClient: HTTPClientProtocol,
         emailValidation: EmailValidator
    )
    
    {
        self.httpClient = httpClient
        self.emailValidation = emailValidation
    }
    
    //MARK: - signIn
    func signIn(loginRequest: LoginRequest) {
        if let fieldValidationViewModel = validateFields(loginRequest: loginRequest) {
            fieldValidationDelegate?.showMessage(viewModel: fieldValidationViewModel)
        } else {
            loadingHandler?(true)
            
            let rosource = Resource(url: URL(string: "http://localhost:5177/v1/accounts/login")!,
                                    method: .post(loginRequest.toData()),
                                    headers: ["Content-Type": "application/json"],
                                    modelType: AccountModel.self)
            
            httpClient.load(rosource) { [weak self] result in
                switch result {
                case .failure(let error):
                    self?.loadingHandler?(false)
                    switch error {
                        case .badRequest:
                            print("Email ou senha invalida")
                        default: return
                    }
                case .success(let accountModel):
                    if let accountModel = accountModel {
                        self?.onLoginSuccess?()
                    }
                }
            }
        }
    }
    
    //MARK: - goToForgotPassword
    func goToForgotPassword() {
        
    }
    
    //MARK: - goToSignUp
    func goToSignUp() {
        
    }
}

//MARK: - validateFields
extension LoginViewModel {
    private func validateFields(loginRequest: LoginRequest) -> FieldValidationViewModel? {
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
        } else if !emailValidation.isValid(email: email) {
            return FieldValidationViewModel(message: Strings.FieldValidationMessages.emailInvalid, type: .email)
        }
        return nil
    }
}
