import Foundation

protocol Validation {
    func validate(data: [String:  Any]?) -> ValidationFieldModel?
}

struct ValidationFieldModel {
    let message: String
    let type: FieldType
}
