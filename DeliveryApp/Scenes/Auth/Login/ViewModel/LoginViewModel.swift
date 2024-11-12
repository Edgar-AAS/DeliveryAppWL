import Foundation

final class LoginViewModel: LoginViewModelProtocol {
    //MARK: - Properties
    var loadingHandler: ((LoadingStateModel) -> ())?
    var onLoginSuccess: (() -> Void)?
    
    private let validatorComposite: ValidationProtocol
    private let userAccountLogin: AccountLoginUseCase
    
    weak var fieldValidationDelegate: FieldValidationDelegate?
    weak var alertView: AlertViewProtocol?
    
    //MARK: - Initializers
    init(userAccountLogin: AccountLoginUseCase, validatorComposite: ValidationProtocol) {
        self.userAccountLogin = userAccountLogin
        self.validatorComposite = validatorComposite
    }
    
    //MARK: - signIn
    func login(credential: LoginCredential) {
        if let fieldValidatorModel = validatorComposite.validate(data: credential.toJson()) {
            fieldValidationDelegate?.display(viewModel: fieldValidatorModel)
        } else {
            loadingHandler?(LoadingStateModel(isLoading: true))
            
            userAccountLogin.login(with: credential) { [weak self] result in
                switch result {
                case .success(_):
                    self?.loadingHandler?(LoadingStateModel(isLoading: false))
                    self?.onLoginSuccess?()
                case .failure(let httpError):
                    self?.loadingHandler?(LoadingStateModel(isLoading: false))
                    self?.handleNetworkError(httpError)
                }
            }
        }
    }
    
    private func handleNetworkError(_ error: HttpError) {
        var message = ""
        
        switch error {
        case .noConnectivity:
            message = Strings.NetworkErrorMessages.noConnectivity
        case .serverError:
            message = Strings.NetworkErrorMessages.serverError
        case .timeout:
            message = Strings.NetworkErrorMessages.timeout
        case .badRequest:
            message = Strings.LoginAccount.Failure.invalidCredentials
        default:
            message = Strings.NetworkErrorMessages.unexpectedError
        }
        
        alertView?.showMessage(viewModel: AlertViewModel(title: Strings.NetworkErrorMessages.errorTitle, message: message))
    }
}
