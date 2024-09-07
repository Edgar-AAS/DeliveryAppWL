import Foundation

class RegisterViewModel: RegisterViewModelProtocol {
//MARK: - Properties
    private let emailValidator: EmailValidator
    private let coordinator: Coordinator
    private var hasAssignedTerms = false
    var loadingHandler: ((Bool) -> ())?
    
    weak var alertView: AlertView?
    weak var fieldValidationDelegate: FieldValidationDelegate?
    
//MARK: - Initializers
    init(emailValidator: EmailValidator,
         coordinator: Coordinator)
    {
        self.emailValidator = emailValidator
        self.coordinator = coordinator
    }
    
//MARK: - createUser
    func createUser(userRequest: RegisterUserRequest) {
        if let validationViewModel = validateFields(userRequest: userRequest) {
            fieldValidationDelegate?.showMessage(viewModel: validationViewModel)
            return
        }
        
        if !hasAssignedTerms {
            showAlert(
                title: AlertViewMessages.validationFailureTitle,
                message: AlertViewMessages.validationFailureDescription
            )
            return
        }
                
        loadingHandler?(true)
    }

//MARK: - routeToHome
    func routeToHome() {
        coordinator.eventOcurred(type: .goToHome)
    }
    
//MARK: - routeToLogin
    func routeToLogin() {
        coordinator.eventOcurred(type: .registerToLogin)
    }
    
//MARK: - toggleTerms
    func toggleTerms(assined: Bool) {
        hasAssignedTerms = assined
    }
    
//MARK: - validateFields
    private func validateFields(userRequest: RegisterUserRequest) -> FieldValidationViewModel? {
        if userRequest.email.isEmpty {
            return FieldValidationViewModel(message: FieldValidationMessages.emailEmpty, type: .email)
        } else if !emailValidator.isValid(email: userRequest.email) {
            return FieldValidationViewModel(message: FieldValidationMessages.emailInvalid, type: .email)
        } else if userRequest.username.isEmpty {
            return FieldValidationViewModel(message: FieldValidationMessages.usernameEmpty, type: .regular)
        } else if userRequest.password.isEmpty {
            return FieldValidationViewModel(message: FieldValidationMessages.passwordEmpty, type: .password)
        } else if userRequest.confirmPassword.isEmpty {
            return FieldValidationViewModel(message: FieldValidationMessages.confirmPasswordEmpty, type: .passwordConfirm)
        } else if userRequest.password != userRequest.confirmPassword {
            return FieldValidationViewModel(message: FieldValidationMessages.passwordsDoNotMatch, type: .passwordConfirm)
        }  else { return nil }
    }

//MARK: - showAlert
    private func showAlert(title: String, message: String) {
        let alertViewModel = AlertViewModel(title: title, message: message)
        alertView?.showMessage(viewModel: alertViewModel)
    }
}

