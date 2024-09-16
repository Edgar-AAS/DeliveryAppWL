import UIKit

class AuthCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private let navigationController: CustomNavigationController

    init(navigationController: CustomNavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        showLoginScreen()
    }

    func showLoginScreen() {
        let viewController = HomeBuilder.build()
        navigationController.setRootViewController(viewController)
    }

    func showRegisterScreen() {
        let viewController = RegisterBuilder.build(coordinator: self)
        navigationController.pushViewController(viewController)
    }
    
    func backToLogin() {
        guard let viewController = navigationController.viewControllers
            .first(where: { $0 is LoginViewController }) else { return }
        navigationController.pop(to: viewController)
    }
    
    func showRegistrationSuccessScreen() {
        let viewController = RegistrationSuccessBuilder.build(coordinator: self)
        navigationController.pushViewController(viewController)
    }
    
    func showHomeCoordinator() {
        let profileCoordinator = HomeCoordinator(navigationController: navigationController)
        childCoordinators.append(profileCoordinator)
        profileCoordinator.start()
    }
}


class HomeCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    private let navigationController: CustomNavigationController

    init(navigationController: CustomNavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showHomeScreen()
    }
    
    func showHomeScreen() {
        let viewController = HomeBuilder.build()
        navigationController.pushViewController(viewController)
    }
}
