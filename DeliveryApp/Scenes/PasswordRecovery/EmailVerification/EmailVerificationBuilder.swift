import Foundation

class EmailVerificationBuilder {
    static func build(coordinator: MainCoordinator, user: User) -> EmailVerificationViewController {
        let viewModel = EmailVerificationViewModel(coordinator: coordinator, user: user)
        let viewController = EmailVerificationViewController(viewModel: viewModel)
        return viewController
    }
}
