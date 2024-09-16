import Foundation

class RegistrationSuccessViewModel: RegistrationSuccessViewModelProtocol {
//MARK: - Properties
    private let coordinator: AuthCoordinator
    
//MARK: - Initializers
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
    
//MARK: - goToLogin
    func goToLogin() {
        coordinator.backToLogin()
    }
}
