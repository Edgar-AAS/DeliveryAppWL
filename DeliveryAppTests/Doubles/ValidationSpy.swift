import Foundation
@testable import DeliveryApp

class ValidationSpy: ValidationProtocol
{
    var validationModel: ValidationFieldModel?
    var data: [String: Any]?
    
    func validate(data: [String : Any]?) -> ValidationFieldModel? {
        self.data = data
        return validationModel
    }
    
    func simulateError(_ validationModel: ValidationFieldModel) {
        self.validationModel = validationModel
    }
}


