import Foundation

final class PasswordValidation: Validation {
    private let fieldName: String
    private let fieldLabel: String
    
    init(fieldName: String, fieldLabel: String) {
        self.fieldName = fieldName
        self.fieldLabel = fieldLabel
    }
    
    func validate(data: [String : Any]?) -> String? {
        let minimumLength = 8
        let uppercaseLetterPattern = ".*[A-Z].*"
        let lowercaseLetterPattern = ".*[a-z].*"
        let digitPattern = ".*\\d.*"
        let specialCharacterPattern = ".*[!@#$%^&*(),.?\":{}|<>].*"
        
        guard let password = data?[fieldName] as? String else {
            return "Incorrect field"
        }
        
        if password.count < minimumLength {
            return "A senha deve ter pelo menos \(minimumLength) caracteres."
        }
        
        if !matchesPattern(uppercaseLetterPattern, in: password) {
            return "A senha deve conter pelo menos uma letra maiúscula."
        }
        
        if !matchesPattern(lowercaseLetterPattern, in: password) {
            return "A senha deve conter pelo menos uma letra minúscula."
        }
        
        if !matchesPattern(digitPattern, in: password) {
            return "A senha deve conter pelo menos um número."
        }
        
        if !matchesPattern(specialCharacterPattern, in: password) {
            return "A senha deve conter pelo menos um caractere especial (ex: !@#$%^&*)."
        }
        
        return nil
    }
    
    private func matchesPattern(_ pattern: String, in text: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: text.utf16.count)
        return regex?.firstMatch(in: text, options: [], range: range) != nil
    }
}
