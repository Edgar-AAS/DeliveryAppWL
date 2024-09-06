import Foundation

protocol FieldValidationDelegate: AnyObject {
    func showMessage(viewModel: FieldValidationViewModel)
}

struct FieldValidationViewModel: Equatable {
    let message: String
    let type: FieldType
}
