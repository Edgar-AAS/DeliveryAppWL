import Foundation

class ValidationComposite: ValidationProtocol {
    private let validations: [ValidationProtocol]
    
    init(validations: [ValidationProtocol]) {
        self.validations = validations
    }
    
    func validate(data: [String : Any]?) -> ValidationFieldModel? {
        for validation in validations {
            if let validationFieldModel = validation.validate(data: data) {
                return validationFieldModel
            }
        }
        return nil
    }
}
