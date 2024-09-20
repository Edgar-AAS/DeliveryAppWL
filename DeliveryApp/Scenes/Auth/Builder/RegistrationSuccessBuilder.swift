import Foundation

class RegistrationSuccessBuilder {
    static func build() -> RegistrationSuccessViewController {
        let viewModel = RegistrationSuccessViewModel()
        let viewController = RegistrationSuccessViewController(viewModel: viewModel)
        return viewController
    }
}
