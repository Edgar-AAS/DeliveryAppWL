import Foundation

final class LoginViewModel: LoginViewModelProtocol {
    //MARK: - Properties
    var loadingHandler: ((LoadingState) -> ())?
    var onLoginSuccess: (() -> Void)?
    
    private let validatorComposite: Validation
    private let userAccountLogin: AccountLoginUseCase
    
    weak var fieldValidationDelegate: FieldValidationDelegate?
    weak var alertView: AlertView?
    
    //MARK: - Initializers
    init(userAccountLogin: AccountLoginUseCase, validatorComposite: Validation) {
        self.userAccountLogin = userAccountLogin
        self.validatorComposite = validatorComposite
    }
    
    //MARK: - signIn
    func signIn(credential: LoginCredential) {
        if let fieldValidatorModel = validatorComposite.validate(data: credential.toJson()) {
            fieldValidationDelegate?.display(viewModel: fieldValidatorModel)
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
