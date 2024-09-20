import UIKit

final class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
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
    
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
//            return
//        }
//        
//        // Verifica se a viewController foi removida da pilha
//        if navigationController.viewControllers.contains(fromViewController) {
//            return
//        }
//        
//        if let registerViewController = fromViewController as? RegisterViewController {
//            childDidFinish(registerViewController.coordinator)
//        }
//    }
}
