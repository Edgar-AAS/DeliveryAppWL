import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLoginFlow()
    }
    
    func showLoginFlow() {
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        addChild(loginCoordinator)
        loginCoordinator.parentCoordinator = self
        loginCoordinator.start()
    }
    
    func showMainTabBarFlow() {
        for coordinator in childCoordinators {
            if let loginCoordinator = coordinator as? LoginCoordinator {
                childDidFinish(loginCoordinator)
                break
            }
        }
        
        let mainTabController = MainTabBarController(coordinator: self)
        mainTabController.coordinator = self
        navigationController.pushViewController(mainTabController, animated: false)
    }
}
