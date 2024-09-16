import Foundation

class EmailVerificationBuilder {
    static func build(user: User) -> EmailVerificationViewController {
        let viewModel = EmailVerificationViewModel(user: user)
        let viewController = EmailVerificationViewController(viewModel: viewModel)
        return viewController
    }
}
