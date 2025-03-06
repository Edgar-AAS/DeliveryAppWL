import Foundation
@testable import DeliveryApp

final class ValidationSpy: Validation {
    var errorMessage: String?
    var data: [String: Any]?
    
    func validate(data: [String : Any]?) -> String? {
        self.data = data
        return errorMessage
    }
    
    func simulateError(errorMessage: String) {
        self.errorMessage = errorMessage
    }
}
