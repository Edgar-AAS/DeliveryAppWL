import Foundation

final class CompareFieldsValidation: Validation, Equatable {
    private let fieldName: String
    private let fieldNameToCompare: String
    private let fieldLabel: String
    
    init(fieldName: String, fieldLabel: String, fieldNameToCompare: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
        self.fieldNameToCompare = fieldNameToCompare
    }
    
    func validate(data: [String : Any]?) -> String? {
        guard
            let fieldName = data?[fieldName] as? String,
            let fieldNameToCompare = data?[fieldNameToCompare] as? String,
            fieldName == fieldNameToCompare
        else {
            return "O campo \(fieldLabel) é inválido."
        }
        return nil
    }
    
    static func == (lhs: CompareFieldsValidation, rhs: CompareFieldsValidation) -> Bool {
        return
            lhs.fieldLabel == rhs.fieldLabel &&
            lhs.fieldName == rhs.fieldName &&
            lhs.fieldNameToCompare == rhs.fieldNameToCompare
    }
}
