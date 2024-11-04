import Foundation

struct RequiredFieldValidator: Validation {
    private let fieldName: String
    private let fieldLabel: String
    private let fieldType: FieldType
    
    init(fieldName: String, fieldLabel: String, fieldType: FieldType) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
        self.fieldType = fieldType
    }
    
    func validate(data: [String : Any]?) -> ValidationFieldModel? {
        guard let fieldName = data?[fieldName] as? String, !fieldName.isEmpty else {
            return ValidationFieldModel(message: "O Campo \(fieldLabel) é obrigatório", type: fieldType)
        }
        return nil
    }
}

