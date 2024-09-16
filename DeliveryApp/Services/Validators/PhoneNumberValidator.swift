import Foundation

class PhoneNumberValidator: PhoneValidator {
    func isValid(phoneNumber: String) -> Bool {
        let phoneRegex = "^\\(\\d{2}\\) 9\\d{4}-\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: phoneNumber)
    }
}
