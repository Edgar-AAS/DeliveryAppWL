import Foundation

public final class ValidationComposite: Validation {
    private let validations: [Validation]
    
    init(validations: [Validation]) {
        self.validations = validations
    }
    
    func validate(data: [String : Any]?) -> String? {
        for validation in validations {
            if let errorMessage = validation.validate(data: data) {
                return errorMessage
            }
        }
        return nil
    }
}
