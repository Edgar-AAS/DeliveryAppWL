import Foundation

final class LoginViewModel: UserLoginHandler {
    //MARK: - Properties
    var loadingHandler: ((Bool) -> ())?
    var onSuccess: (() -> Void)?
    
    private let validatorComposite: Validation
    private let loginAccount: LoginAccountUseCase

    weak var alertView: AlertViewProtocol?
    
    //MARK: - Initializers
    init(userAccountLogin: LoginAccountUseCase, validatorComposite: Validation) {
        self.loginAccount = userAccountLogin
        self.validatorComposite = validatorComposite
    }
    
    //MARK: - login
    func login(credential: AuthRequest) {
        if let message = validatorComposite.validate(data: credential.toJson()) {
            showAlert(title: Strings.error, message: message)
        } else {
            loadingHandler?(true)
            
            loginAccount.login(with: credential) { [weak self] result in
                switch result {
                case .success(_):
                    self?.loadingHandler?(false)
                    self?.onSuccess?()
                case .failure(let error):
                    self?.loadingHandler?(false)
                    self?.showAlert(title: Strings.error, message: error.customMessage)
                }
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alertViewModel = AlertViewModel(title: title, message: message)
        alertView?.showMessage(viewModel: alertViewModel)
    }
}
