import Foundation

class RegistrationSuccessBuilder {
    static func build(coordinator: AuthCoordinator) -> RegistrationSuccessViewController {
        let viewModel = RegistrationSuccessViewModel(coordinator: coordinator)
        let viewController = RegistrationSuccessViewController(viewModel: viewModel)
        return viewController
    }
}
