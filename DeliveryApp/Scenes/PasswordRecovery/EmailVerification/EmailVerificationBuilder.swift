import Foundation

class EmailVerificationBuilder {
    static func build(coordinator: MainCoordinator, user: User) -> EmailVerificationViewController {
        let passwordReset = FirebasePasswordReset()
        let viewModel = EmailVerificationViewModel(coordinator: coordinator, user: user, passwordReset: passwordReset)
        let viewController = EmailVerificationViewController(viewModel: viewModel)
        return viewController
    }
}
