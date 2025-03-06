import Foundation

final class EmailValidation: Validation, Equatable {
    private let fieldName: String
    private let fieldLabel: String
    private let emailValidator: EmailValidatable
    
    init(fieldName: String, fieldLabel: String, emailValidator: EmailValidatable) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
        self.emailValidator = emailValidator
    }
    
    func validate(data: [String : Any]?) -> String? {
        guard
            let email = data?[fieldName] as? String, emailValidator.isValid(email)
        else {
            return "O campo \(fieldLabel) é inválido."
        }
        
        return nil
    }
    
    static func == (lhs: EmailValidation, rhs: EmailValidation) -> Bool {
        return lhs.fieldLabel == rhs.fieldLabel && lhs.fieldName == rhs.fieldName
    }
}
