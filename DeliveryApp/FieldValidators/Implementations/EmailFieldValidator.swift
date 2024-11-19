import Foundation

final class EmailFieldValidator: ValidationProtocol {
    private let fieldName: String
    private let fieldLabel: String
    private let emailValidator: EmailValidationProtocol
    
    init(fieldName: String, fieldLabel: String, emailValidator: EmailValidationProtocol) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
        self.emailValidator = emailValidator
    }
    
    func validate(data: [String : Any]?) -> ValidationFieldModel? {
        guard let fieldValue = data?[fieldName] as? String, emailValidator.isValid(email: fieldValue) else {
            return ValidationFieldModel(
                message: "O campo \(fieldLabel) está inválido"
            )
        }
        return nil
    }
}


