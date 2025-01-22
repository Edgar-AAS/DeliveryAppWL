import Foundation

protocol FeedBackTextFieldProtocol: AnyObject {
    func clearError()
    func displayError(validationModel: ValidationFieldModel)
}
