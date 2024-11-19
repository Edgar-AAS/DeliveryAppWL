import Foundation

protocol ValidationProtocol: AnyObject {
    func validate(data: [String:  Any]?) -> ValidationFieldModel?
}

class ValidationFieldModel: Equatable {
    let message: String
    
    init(message: String) {
        self.message = message
    }
    
    static func == (lhs: ValidationFieldModel, rhs: ValidationFieldModel) -> Bool {
        return
            lhs.message == rhs.message
       }
}
