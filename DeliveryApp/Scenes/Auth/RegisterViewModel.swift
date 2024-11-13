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
            fieldValidationDelegate?.display(viewModel: validationFieldModel)
            return
        }
        
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
            case .failure(let httpError):
                self?.loadingHandler?(.init(isLoading: false))
                self?.handleNetworkError(httpError)
            }
        }
    }
    
    func toggleTerms(assined: Bool) {
        hasAssignedTerms = assined
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
            message = Strings.RegistrationAccount.Failure.emailInUse
        default:
            message = Strings.NetworkErrorMessages.unexpectedError
        }
        
        showAlert(title: Strings.NetworkErrorMessages.errorTitle, message: message)
    }
    
    func showAlert(title: String, message: String) {
        alertView?.showMessage(viewModel: AlertViewModel(title: title, message: message))
    }
}
