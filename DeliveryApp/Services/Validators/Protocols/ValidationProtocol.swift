import Foundation

protocol ValidationProtocol: AnyObject {
    func validate(data: [String:  Any]?) -> ValidationFieldModel?
}

class ValidationFieldModel: Equatable {
    let message: String
    let type: FieldType
    
    init(message: String, type: FieldType) {
        self.message = message
        self.type = type
    }
    
    static func == (lhs: ValidationFieldModel, rhs: ValidationFieldModel) -> Bool {
        return
            lhs.message == rhs.message &&
            lhs.type == rhs.type
       }
}
