import Foundation

final class CompareFieldsValidator: ValidationProtocol {
    private let fieldName: String
    private let fieldLabel: String
    private let fieldNameToCompare: String
    
    init(fieldName: String, fieldLabel: String, fieldNameToCompare: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
        self.fieldNameToCompare = fieldNameToCompare
    }
    
    func validate(data: [String : Any]?) -> ValidationFieldModel? {
        guard let fieldValue = data?[fieldName] as? String,
              let fieldValueToCompare = data?[fieldNameToCompare] as? String, fieldValue == fieldValueToCompare
        else {
            return ValidationFieldModel(message: "O campo \(fieldLabel) está inválido")
        }
        return nil
    }
}
