import Foundation

final class PasswordStrongValidator: ValidationProtocol {
    private let fieldName: String
    private let fieldType: String
    private let passwordValidator: PasswordValidationProtocol
    
    init(fieldName: String, fieldType: String, passwordValidator: PasswordValidationProtocol) {
        self.fieldName = fieldName
        self.fieldType = fieldType
        self.passwordValidator = passwordValidator
    }
    
    func validate(data: [String : Any]?) -> ValidationFieldModel? {
        guard let fieldValue = data?[fieldName] as? String else {
            return ValidationFieldModel(
                fieldType: fieldType,
                message: "Dado inválido ou não informado"
            )
        }
        
        if let errorMessage = passwordValidator.isValid(password: fieldValue) {
            return ValidationFieldModel(
                fieldType: fieldType,
                message: errorMessage
            )
        }
    
        return nil
    }
}
