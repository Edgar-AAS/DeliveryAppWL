import Foundation

protocol RegistrationSuccessViewModelProtocol {
    func getRegistrationSuccessModel() -> RegistrationSuccessModel
    func goToLogin()
}

class RegistrationSuccessViewModel: RegistrationSuccessViewModelProtocol {
//MARK: - Properties
    private let registrationSuccessModel: RegistrationSuccessModel
    private let coordinator: Coordinator
    
//MARK: - Initializers
    init(model: RegistrationSuccessModel, coordinator: Coordinator) {
        self.registrationSuccessModel = model
        self.coordinator = coordinator
    }
    
//MARK: - RegistrationSuccessViewModelProtocol Methods
    func getRegistrationSuccessModel() -> RegistrationSuccessModel {
        return registrationSuccessModel
    }
    
    func goToLogin() {
        coordinator.eventOcurred(type: .backToLogin)
    }
}
