import Foundation

protocol EmailValidator {
    func isValid(email: String) -> Bool
}
