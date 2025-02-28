import Foundation

final class EmailValidation: Validation, Equatable {
    private let fieldName: String
    private let fieldLabel: String
    
    init(fieldName: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }
    
    func validate(data: [String : Any]?) -> String? {
        guard
            let fieldValue = data?[fieldName] as? String, validate(email: fieldValue)
        else {
            return "O campo \(fieldLabel) é inválido."
        }
        
        return nil
    }
    
    static func == (lhs: EmailValidation, rhs: EmailValidation) -> Bool {
        return lhs.fieldLabel == rhs.fieldLabel && lhs.fieldName == rhs.fieldName
    }
    
    private func validate(email: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: pattern)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
}

