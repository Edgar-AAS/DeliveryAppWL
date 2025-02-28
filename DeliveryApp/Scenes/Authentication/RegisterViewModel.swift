import Foundation

final class RegisterViewModel: RegisterViewModelProtocol{
    private var hasAssignedTerms = false
    
    var loadingHandler: ((Bool) -> ())?
    var createdAccountCallBack: (() -> Void)?
    
    weak var alertView: AlertViewProtocol?
    
    private let createAccount: RegisterAccountUseCase
    private let validatorComposite: Validation
    
    //MARK: - Initializers
    init(validatorComposite: Validation, createAccount: RegisterAccountUseCase) {
        self.createAccount = createAccount
        self.validatorComposite = validatorComposite
    }
    
    //MARK: - createUsers
    func createAccount(userRequest: RegisterAccountModel) {
        if let message = validatorComposite.validate(data: userRequest.toJson()) {
            showAlert(title: "Falha na validaçāo.", message: message)
            return
        }
        
        if !hasAssignedTerms {
            showAlert(
                title: Strings.RegistrationAccount.Failure.validationFailureTitle,
                message: Strings.RegistrationAccount.Failure.unsignedTerms
            )
            return
        }
        
        let createAccountModel = RegisterAccountRequest(
            name: userRequest.username,
            email: userRequest.email,
            password: userRequest.password
        )
        
        loadingHandler?(true)
        createAccount.register(with: createAccountModel) { [weak self] result in
            switch result {
            case .success(_):
                self?.loadingHandler?(false)
                self?.createdAccountCallBack?()
            case .failure(let error):
                self?.loadingHandler?(false)
                self?.showAlert(title: Strings.error, message: error.customMessage)
            }
        }
    }
    
    func toggleTerms(assined: Bool) {
        hasAssignedTerms = assined
    }
    
    private func showAlert(title: String, message: String) {
        alertView?.showMessage(viewModel: AlertViewModel(title: title, message: message))
    }
}
