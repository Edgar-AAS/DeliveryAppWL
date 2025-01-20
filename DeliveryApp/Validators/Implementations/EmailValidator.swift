import Foundation

final class EmailValidator: EmailValidationProtocol {
    func isValid(email: String) -> Bool {
        let emailRegex = "^(?=.{1,254}$)(?=.{1,64}@)[A-Za-z0-9](?:[A-Za-z0-9._%+-]*[A-Za-z0-9])?@[A-Za-z0-9](?:[A-Za-z0-9-]*[A-Za-z0-9])?(?:\\.[A-Za-z]{2,})+$"
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: emailRegex)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
}
