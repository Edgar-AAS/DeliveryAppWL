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
            print(validationFieldModel)
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
                case .failure(let error):
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
    
//    private func validateFields(userRequest: RegisterUserRequest) -> FieldValidationViewModel? {
//        if userRequest.email.isEmpty {
//            return FieldValidationViewModel(message: Strings.FieldValidationMessages.emailEmpty, type: .email)
//        } else if !emailValidator.isValid(email: userRequest.email) {
//            return FieldValidationViewModel(message: Strings.FieldValidationMessages.emailInvalid, type: .email)
//        } else if userRequest.username.isEmpty {
//            return FieldValidationViewModel(message: Strings.FieldValidationMessages.usernameEmpty, type: .regular)
//        } else if userRequest.password.isEmpty {
//            return FieldValidationViewModel(message: Strings.FieldValidationMessages.passwordEmpty, type: .password)
//        } else if userRequest.confirmPassword.isEmpty {
//            return FieldValidationViewModel(message: Strings.FieldValidationMessages.confirmPasswordEmpty, type: .passwordConfirm)
//        } else if userRequest.password != userRequest.confirmPassword {
//            return FieldValidationViewModel(message: Strings.FieldValidationMessages.passwordsDoNotMatch, type: .passwordConfirm)
//        }  else { return nil }
//    }
    
    private func showAlert(title: String, message: String) {
        let alertViewModel = AlertViewModel(title: title, message: message)
        alertView?.showMessage(viewModel: alertViewModel)
    }
}
