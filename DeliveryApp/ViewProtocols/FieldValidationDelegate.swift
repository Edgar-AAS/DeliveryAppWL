import Foundation

protocol FieldValidationDelegate: AnyObject {
    func clearError()
    func displayError(validationModel: ValidationFieldModel)
}
