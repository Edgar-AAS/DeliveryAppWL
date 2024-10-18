import UIKit

class RegisterCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: LoginCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let registerViewController = RegisterBuilder.build()
        registerViewController.loginAction = { [weak self] in
            self?.navigateToLogin()
        }
        navigationController.pushViewController(registerViewController, animated: true)
    }
    
    func navigateToLogin() {
        if let loginViewController = navigationController.viewControllers.first(where: { $0 is LoginViewController }) {
            navigationController.popToViewController(loginViewController, animated: true)
        } else {
            let loginCoordinator = LoginCoordinator(navigationController: navigationController)
            loginCoordinator.parentCoordinator = parentCoordinator?.parentCoordinator
            parentCoordinator?.addChild(loginCoordinator)
            loginCoordinator.start()
        }
        
        parentCoordinator?.childDidFinish(self)
    }
}
