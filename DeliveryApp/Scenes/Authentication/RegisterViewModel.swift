import Foundation

final class RegisterViewModel: RegisterViewModelProtocol{
    private var hasAssignedTerms = false
    var loadingHandler: ((LoadingStateModel) -> ())?
    var createdAccountCallBack: (() -> Void)?
    
    weak var alertView: AlertViewProtocol?
    weak var fieldValidationDelegate: FieldValidationDelegate?
    
    private let createAccount: CreateAccountUseCase
    private let validatorComposite: ValidationProtocol
    
    //MARK: - Initializers
    init(validatorComposite: ValidationProtocol, createAccount: CreateAccountUseCase) {
        self.createAccount = createAccount
        self.validatorComposite = validatorComposite
    }
    
    //MARK: - createUsers
    func createAccount(userRequest: RegisterUserRequest) {
        if let validationFieldModel = validatorComposite.validate(data: userRequest.toJson()) {
            fieldValidationDelegate?.displayError(validationModel: validationFieldModel)
            return
        }
        
        fieldValidationDelegate?.clearError()
        
        if !hasAssignedTerms {
            showAlert(
                title: Strings.RegistrationAccount.Failure.validationFailureTitle,
                message: Strings.RegistrationAccount.Failure.unsignedTerms
            )
            return
        }
        
        let createAccountModel = CreateAccountModel(
            name: userRequest.username,
            email: userRequest.email,
            password: userRequest.password
        )
        
        loadingHandler?(.init(isLoading: true))
        
        createAccount.create(with: createAccountModel) { [weak self] result in
            switch result {
            case .success(_):
                self?.loadingHandler?(.init(isLoading: false))
                self?.createdAccountCallBack?()
            case .failure(let error):
                self?.loadingHandler?(.init(isLoading: false))
                self?.handleRegisterError(error)
            }
        }
    }
    
    func toggleTerms(assined: Bool) {
        hasAssignedTerms = assined
    }
    
    private func handleRegisterError(_ error: RegisterError) {
        var message = ""
        
        switch error {
        case .noConnectivity:
            message = Strings.NetworkError.noConnectivity
        case .emailInUse:
            message = Strings.CreateAccount.Failure.emailInUse
        default:
            message = Strings.NetworkError.unexpectedError
        }
        
        showAlert(
            title: Strings.NetworkError.errorTitle,
            message: message
        )
    }
    
    func showAlert(title: String, message: String) {
        alertView?.showMessage(viewModel: AlertViewModel(title: title, message: message))
    }
}
