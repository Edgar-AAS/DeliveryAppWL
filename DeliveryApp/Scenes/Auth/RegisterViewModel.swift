import Foundation

final class RegisterViewModel: RegisterViewModelProtocol{
    private var hasAssignedTerms = false
    
    var loadingHandler: ((LoadingState) -> ())?
    var createdAccountCallBack: (() -> Void)?
    
    weak var alertView: AlertView?
    weak var fieldValidationDelegate: FieldValidationDelegate?
    
    private let createAccount: CreateAccountUseCase
    private let validatorComposite: Validation
    
    //MARK: - Initializers
    init(validatorComposite: Validation, createAccount: CreateAccountUseCase) {
        self.createAccount = createAccount
        self.validatorComposite = validatorComposite
    }
    
    //MARK: - createUsers
    func createUser(userRequest: RegisterUserRequest) {
        if let validationFieldModel = validatorComposite.validate(data: userRequest.toJson()) {
            fieldValidationDelegate?.display(viewModel: validationFieldModel)
            return
        }
        
        if !hasAssignedTerms {
            showAlert(
                title: Strings.AlertViewMessages.validationFailureTitle,
                message: Strings.AlertViewMessages.validationFailureDescription
            )
            return
        }
        
        let createAccountModel = CreateAccountModel(
            name: userRequest.username,
            email: userRequest.email,            
            password: userRequest.password
        )
        
        createAccount.create(with: createAccountModel) { [weak self] result in
            self?.loadingHandler?(.init(isLoading: true))
            
            switch result {
                case .success(let accountStatusResponse):
                    self?.loadingHandler?(.init(isLoading: false))
                    self?.alertView?.showMessage(viewModel: AlertViewModel(title: "Conta Criada",
                                                                           message: accountStatusResponse.message))
                    self?.createdAccountCallBack?()
                case .failure(_):
                    self?.loadingHandler?(.init(isLoading: false))
                    self?.alertView?.showMessage(viewModel: AlertViewModel(
                        title: "Erro",
                        message: "Algo inesperado aconteceu, tente novamente em instantes."))
            }
        }
    }
    
    func toggleTerms(assined: Bool) {
        hasAssignedTerms = assined
    }
    
    private func showAlert(title: String, message: String) {
        let alertViewModel = AlertViewModel(title: title, message: message)
        alertView?.showMessage(viewModel: alertViewModel)
    }
}
