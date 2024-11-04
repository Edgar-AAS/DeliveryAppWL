import Foundation

protocol EmailValidation {
   func isValid(email: String) -> Bool
}

struct EmailValidatorAdapter: EmailValidation {
   private let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
   
   func isValid(email: String) -> Bool {
       let range = NSRange(location: 0, length: email.utf16.count)
       let regex = try! NSRegularExpression(pattern: emailRegex)
       return regex.firstMatch(in: email, options: [], range: range) != nil
   }
}
