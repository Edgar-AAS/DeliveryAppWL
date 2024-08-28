import Foundation


class RegistrationSuccessBuilder {
    static func build(model: RegistrationSuccessModel, coordinator: Coordinator) -> RegistrationSuccessViewController {
        let viewModel = RegistrationSuccessViewModel(model: model, coordinator: coordinator)
        let viewController = RegistrationSuccessViewController(viewModel: viewModel)
        return viewController
    }
}
