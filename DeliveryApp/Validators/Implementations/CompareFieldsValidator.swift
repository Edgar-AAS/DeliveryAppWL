import Foundation

final class CompareFieldsValidator: ValidationProtocol {
    private let fieldName: String
    private let fieldType: String
    private let fieldLabel: String
    private let fieldNameToCompare: String
    
    init(fieldName: String, fieldType: String, fieldLabel: String, fieldNameToCompare: String) {
        self.fieldName = fieldName
        self.fieldType = fieldType
        self.fieldLabel = fieldLabel
        self.fieldNameToCompare = fieldNameToCompare
    }
    
    func validate(data: [String : Any]?) -> ValidationFieldModel? {
        guard let fieldValue = data?[fieldName] as? String,
              let fieldValueToCompare = data?[fieldNameToCompare] as? String, fieldValue == fieldValueToCompare
        else {
            return ValidationFieldModel(fieldType: fieldType, message: "O campo \(fieldLabel) está inválido")
        }
        return nil
    }
}
