import Foundation
@testable import DeliveryApp

final class EmailValidatorSpy: EmailValidatable {
    private(set)var isValid: Bool = true
    private(set)var email: String = ""
    
    func isValid(_ email: String) -> Bool {
        self.email = email
        return isValid
    }
    
    func simuleInvalidEmail() {
        isValid = false
    }
    
    func simuleValidEmail() {
        isValid = true
    }
}
