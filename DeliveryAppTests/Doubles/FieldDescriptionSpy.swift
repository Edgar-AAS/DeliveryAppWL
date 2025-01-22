import Foundation
@testable import DeliveryApp

class FieldDescriptionSpy: FeedBackTextFieldProtocol {
    private(set) var clearErrorCallsCount = 0
    private(set) var emit: ((ValidationFieldModel) -> Void)?
    
    func clearError() {
        clearErrorCallsCount += 1
    }
    
    func displayError(validationModel: ValidationFieldModel) {
        self.emit?(validationModel)
    }
    
    func observe(completion: @escaping (ValidationFieldModel) -> Void) {
        self.emit = completion
    }
}
