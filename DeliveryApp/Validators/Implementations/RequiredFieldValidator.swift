import Foundation

final class RequiredFieldValidator: ValidationProtocol {
    private let fieldName: String
    private let fieldLabel: String
    private let fieldType: String
    
    init(fieldName: String, fieldLabel: String, fieldType: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
        self.fieldType = fieldType
    }
    
    func validate(data: [String : Any]?) -> ValidationFieldModel? {
        guard let fieldName = data?[fieldName] as? String, !fieldName.isEmpty else {
            return ValidationFieldModel(fieldType: fieldType, message: "O Campo \(fieldLabel) é obrigatório")
        }
        return nil
    }
}

