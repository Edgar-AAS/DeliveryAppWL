import Foundation

final class LoginViewModel: LoginViewModelProtocol {
    //MARK: - Properties
    var loadingHandler: ((LoadingStateModel) -> ())?
    var onLoginSuccess: (() -> Void)?
    
    private let validatorComposite: ValidationProtocol
    private let userAccountLogin: LoginAccountUseCase
    
    weak var fieldValidationDelegate: FieldValidationDelegate?
    weak var alertView: AlertViewProtocol?
    
    //MARK: - Initializers
    init(userAccountLogin: LoginAccountUseCase, validatorComposite: ValidationProtocol) {
        self.userAccountLogin = userAccountLogin
        self.validatorComposite = validatorComposite
    }
    
    //MARK: - signIn
    func login(credential: AuthResquest) {
        if let validationModel = validatorComposite.validate(data: credential.toJson()) {
            fieldValidationDelegate?.displayError(validationModel: validationModel)
        } else {
            fieldValidationDelegate?.clearError()
            loadingHandler?(LoadingStateModel(isLoading: true))
            
            userAccountLogin.login(with: credential) { [weak self] result in
                switch result {
                case .success(_):
                    self?.loadingHandler?(LoadingStateModel(isLoading: false))
                    self?.onLoginSuccess?()
                case .failure(let loginError):
                    self?.loadingHandler?(LoadingStateModel(isLoading: false))
                    self?.handleLoginError(loginError)
                }
            }
        }
    }
    
    private func handleLoginError(_ error: LoginError) {
        var message = ""
        
        switch error {
        case .noConnectivity:
            message = Strings.NetworkError.noConnectivity
        case .invalidCredentials:
            message = Strings.LoginAccount.Failure.invalidCredentials
        case .unexpected:
            message = Strings.NetworkError.unexpectedError
        }
        
        alertView?.showMessage(viewModel: AlertViewModel(title: Strings.NetworkError.errorTitle, message: message))
    }
}
