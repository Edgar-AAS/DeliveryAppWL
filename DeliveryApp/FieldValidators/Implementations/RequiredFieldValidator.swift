import Foundation

final class RequiredFieldValidator: ValidationProtocol {
    private let fieldName: String
    private let fieldLabel: String
    
    init(fieldName: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }
    
    func validate(data: [String : Any]?) -> ValidationFieldModel? {
        guard let fieldName = data?[fieldName] as? String, !fieldName.isEmpty else {
            return ValidationFieldModel(message: "O Campo \(fieldLabel) é obrigatório")
        }
        return nil
    }
}

