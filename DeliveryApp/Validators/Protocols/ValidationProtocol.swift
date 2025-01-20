import Foundation

protocol ValidationProtocol: AnyObject {
    func validate(data: [String:  Any]?) -> ValidationFieldModel?
}

class ValidationFieldModel: Equatable {
    let fieldType: String
    let message: String
    
    init(fieldType: String, message: String) {
        self.fieldType = fieldType
        self.message = message
    }
    
    static func == (lhs: ValidationFieldModel, rhs: ValidationFieldModel) -> Bool {
        return
            lhs.message == rhs.message &&
            lhs.fieldType == rhs.fieldType
       }
}
