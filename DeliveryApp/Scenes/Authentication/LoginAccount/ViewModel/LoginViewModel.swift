import Foundation

final class LoginViewModel: UserLoginHandler {
    //MARK: - Properties
    var loadingHandler: ((LoadingState) -> ())?
    var onSuccess: (() -> Void)?
    
    private let validatorComposite: ValidationProtocol
    private let userAccountLogin: LoginAccountUseCase
    
    weak var fieldValidationDelegate: FeedBackTextFieldProtocol?
    weak var alertView: AlertViewProtocol?
    
    //MARK: - Initializers
    init(userAccountLogin: LoginAccountUseCase, validatorComposite: ValidationProtocol) {
        self.userAccountLogin = userAccountLogin
        self.validatorComposite = validatorComposite
    }
    
    //MARK: - login
    func login(credential: AuthRequest) {
        if let validationModel = validatorComposite.validate(data: credential.toJson()) {
            fieldValidationDelegate?.displayError(validationModel: validationModel)
        } else {
            fieldValidationDelegate?.clearError()
            loadingHandler?(LoadingState(isLoading: true))
            
            userAccountLogin.login(with: credential) { [weak self] result in
                switch result {
                case .success(_):
                    self?.loadingHandler?(LoadingState(isLoading: false))
                    self?.onSuccess?()
                case .failure(let loginError):
                    self?.loadingHandler?(LoadingState(isLoading: false))
                    self?.handleLoginError(loginError)
                }
            }
        }
    }
    
    private func handleLoginError(_ error: LoginError) {
        let alertViewModel = AlertViewModel(title: Strings.NetworkError.errorTitle, message: error.message)
        alertView?.showMessage(viewModel: alertViewModel)
    }
}
