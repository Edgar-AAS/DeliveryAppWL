import Foundation

final class LoginViewModel: UserLoginHandler {
    //MARK: - Properties
    var loadingHandler: ((Bool) -> ())?
    var onSuccess: (() -> Void)?
    
    private let validatorComposite: ValidationProtocol
    private let loginAccount: LoginAccountUseCase
    
    weak var fieldValidationDelegate: FeedBackTextFieldProtocol?
    weak var alertView: AlertViewProtocol?
    
    //MARK: - Initializers
    init(userAccountLogin: LoginAccountUseCase, validatorComposite: ValidationProtocol) {
        self.loginAccount = userAccountLogin
        self.validatorComposite = validatorComposite
    }
    
    //MARK: - login
    func login(credential: AuthRequest) {
        if let validationModel = validatorComposite.validate(data: credential.toJson()) {
            fieldValidationDelegate?.displayError(validationModel: validationModel)
        } else {
            loadingHandler?(true)
            
            loginAccount.login(with: credential) { [weak self] result in
                switch result {
                case .success(_):
                    self?.loadingHandler?(false)
                    self?.onSuccess?()
                case .failure(let error):
                    self?.loadingHandler?(false)
                    self?.handleLoginError(error)
                }
            }
        }
    }
    
    private func handleLoginError(_ error: LoginError) {
        let alertViewModel = AlertViewModel(
            title: Strings.error,
            message: error.customMessage
        )
        alertView?.showMessage(viewModel: alertViewModel)
    }
}
