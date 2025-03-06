import Foundation

protocol Validation: AnyObject {
    func validate(data: [String:  Any]?) -> String?
}
