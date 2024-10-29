import Foundation

protocol ForgotPasswordViewModelProtocol: AnyObject {
    func sendPasswordReset(with userRequest: ForgotPasswordUserRequest)
    var loadingHandler: ((Bool) -> ())? { get set }
}

class ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {
//MARK: - Properties
    private let emailValidation: EmailValidaton
    
    var loadingHandler: ((Bool) -> ())?
    weak var fieldValidationDelegate: FieldValidationDelegate?
    
//MARK: - Initializers
    init(emailValidator: EmailValidaton) {
        self.emailValidation = emailValidator
    }
    
//MARK: - sendPasswordReset
    func sendPasswordReset(with userRequest: ForgotPasswordUserRequest) {
        if let fieldValidationViewModel = validateEmail(userRequest.email) {
            fieldValidationDelegate?.showMessage(viewModel: fieldValidationViewModel)
        } else {
            loadingHandler?(true)
            //SEND PASSWORD RESET
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                //STOP LOADING AND PUSH VIEW
                self?.loadingHandler?(false)
            }
        }
    }
    
//MARK: - validateEmail
    private func validateEmail(_ email: String) -> FieldValidationViewModel? {
        if email.isEmpty {
            return FieldValidationViewModel(message: Strings.FieldValidationMessages.emailEmpty, type: .email)
        } else if !emailValidation.isValid(email: email) {
            return FieldValidationViewModel(message: Strings.FieldValidationMessages.emailInvalid, type: .email)
        }
        return nil
    }
}
