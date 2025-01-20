import Foundation

final class PasswordValidator: PasswordValidationProtocol {
    func isValid(password: String) -> String? {
        let minimumLength = 8
        let uppercaseLetterPattern = ".*[A-Z].*"
        let lowercaseLetterPattern = ".*[a-z].*"
        let digitPattern = ".*\\d.*"
        let specialCharacterPattern = ".*[!@#$%^&*(),.?\":{}|<>].*"
        
        // Verifica o comprimento da senha
        if password.count < minimumLength {
            return "A senha deve ter pelo menos \(minimumLength) caracteres."
        }
        
        // Verifica se contém ao menos uma letra maiúscula
        if !matchesPattern(uppercaseLetterPattern, in: password) {
            return "A senha deve conter pelo menos uma letra maiúscula."
        }
        
        // Verifica se contém ao menos uma letra minúscula
        if !matchesPattern(lowercaseLetterPattern, in: password) {
            return "A senha deve conter pelo menos uma letra minúscula."
        }
        
        // Verifica se contém ao menos um dígito
        if !matchesPattern(digitPattern, in: password) {
            return "A senha deve conter pelo menos um número."
        }
        
        // Verifica se contém ao menos um caractere especial
        if !matchesPattern(specialCharacterPattern, in: password) {
            return "A senha deve conter pelo menos um caractere especial (ex: !@#$%^&*)."
        }
        
        // Senha válida
        return nil
    }
    
    private func matchesPattern(_ pattern: String, in text: String) -> Bool {
        let regex = try? NSRegularExpression(pattern: pattern)
        let range = NSRange(location: 0, length: text.utf16.count)
        return regex?.firstMatch(in: text, options: [], range: range) != nil
    }
}
