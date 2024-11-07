import Foundation
@testable import DeliveryApp

class FieldDescriptionSpy: FieldValidationDelegate {
    private(set) var emit: ((ValidationFieldModel) -> Void)?
    
    func observe(completion: @escaping (ValidationFieldModel) -> Void) {
        self.emit = completion
    }
    
    func display(viewModel: ValidationFieldModel) {
        self.emit?(viewModel)
    }
}
