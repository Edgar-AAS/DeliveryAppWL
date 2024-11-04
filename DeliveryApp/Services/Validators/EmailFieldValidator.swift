import Foundation

public final class EmailFieldValidator: Validation {
    private let fieldName: String
    private let fieldLabel: String
    private let fieldType: FieldType
    private let emailValidator: EmailValidation
    
    init(fieldName: String, fieldLabel: String, fieldType: FieldType, emailValidator: EmailValidation) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
        self.fieldType = fieldType
        self.emailValidator = emailValidator
    }
    
    func validate(data: [String : Any]?) -> ValidationFieldModel? {
        guard let fieldValue = data?[fieldName] as? String, emailValidator.isValid(email: fieldValue) else {
            return ValidationFieldModel(
                message: "O campo \(fieldLabel) deve conter um email válido.",
                type: .email
            )
        }
        return nil
    }
}


