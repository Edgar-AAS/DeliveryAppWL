import Foundation

class RegisterViewModel: RegisterViewModelProtocol{
    private let httpClient: HTTPClientProtocol
    private let emailValidator: EmailValidaton
    private let phoneValidator: PhoneNumberValidation
    private var hasAssignedTerms = false
    var loadingHandler: ((Bool) -> ())?
    var onRegisterSuccess: (() -> Void)?
    
    weak var alertView: AlertView?
    weak var fieldValidationDelegate: FieldValidationDelegate?
    
    //MARK: - Initializers
    init(httpClient: HTTPClientProtocol,
         emailValidator: EmailValidaton,
         phoneValidator: PhoneNumberValidation
    )
    {
        self.httpClient = httpClient
        self.emailValidator = emailValidator
        self.phoneValidator = phoneValidator
    }
    
    //MARK: - createUser
    func createUser(userRequest: RegisterUserRequest) {
        if let validationViewModel = validateFields(userRequest: userRequest) {
            fieldValidationDelegate?.showMessage(viewModel: validationViewModel)
            return
        }
        
        if !hasAssignedTerms {
            showAlert(
                title: Strings.AlertViewMessages.validationFailureTitle,
                message: Strings.AlertViewMessages.validationFailureDescription
            )
            return
        }
        
        let userPostModel = UserPostModel(
            name: userRequest.username,
            email: userRequest.email, 
            phone: userRequest
                    .phone
                    .components(separatedBy: CharacterSet.decimalDigits.inverted)
                    .joined(),
            password: userRequest.password
        )
        
        let resource = Resource<Data>(
            url: URL(string: "http://localhost:5177/v1/accounts")!,
            method: .post(userPostModel.toData()),
            headers: ["Content-Type": "application/json"]
        )
                
        httpClient.load(resource) { [weak self] result in
            self?.loadingHandler?(true)
            switch result {
            case .success(_):
                self?.loadingHandler?(false)
                self?.onRegisterSuccess?()
            case .failure(_):
                self?.loadingHandler?(false)
            }
        }
    }
    
    //MARK: - toggleTerms
    func toggleTerms(assined: Bool) {
        hasAssignedTerms = assined
    }
    
    //MARK: - validateFields
    private func validateFields(userRequest: RegisterUserRequest) -> FieldValidationViewModel? {
        if userRequest.email.isEmpty {
            return FieldValidationViewModel(message: Strings.FieldValidationMessages.emailEmpty, type: .email)
        } else if !emailValidator.isValid(email: userRequest.email) {
            return FieldValidationViewModel(message: Strings.FieldValidationMessages.emailInvalid, type: .email)
        } else if userRequest.username.isEmpty {
            return FieldValidationViewModel(message: Strings.FieldValidationMessages.usernameEmpty, type: .regular)
        } else if userRequest.phone.isEmpty {
            return FieldValidationViewModel(message: Strings.FieldValidationMessages.phoneEmpty, type: .phone)
        } else if !phoneValidator.isValid(phoneNumber: userRequest.phone) {
            return FieldValidationViewModel(message: Strings.FieldValidationMessages.phoneInvalid, type: .phone)
        } else if userRequest.password.isEmpty {
            return FieldValidationViewModel(message: Strings.FieldValidationMessages.passwordEmpty, type: .password)
        } else if userRequest.confirmPassword.isEmpty {
            return FieldValidationViewModel(message: Strings.FieldValidationMessages.confirmPasswordEmpty, type: .passwordConfirm)
        } else if userRequest.password != userRequest.confirmPassword {
            return FieldValidationViewModel(message: Strings.FieldValidationMessages.passwordsDoNotMatch, type: .passwordConfirm)
        }  else { return nil }
    }
    
    //MARK: - showAlert
    private func showAlert(title: String, message: String) {
        let alertViewModel = AlertViewModel(title: title, message: message)
        alertView?.showMessage(viewModel: alertViewModel)
    }
}
