import Foundation
@testable import DeliveryApp

class EmailValidatorSpy: EmailValidation {
    private(set)var isValid: Bool = true
    private(set)var email: String = ""
    
    func isValid(email: String) -> Bool {
        self.email = email
        return isValid
    }
    
    func completeWithValidEmail() {
        isValid = true
    }
    
    func simulateError() {
        isValid = false
    }
}
