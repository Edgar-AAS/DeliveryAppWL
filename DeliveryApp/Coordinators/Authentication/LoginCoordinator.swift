import UIKit

final class LoginCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    var parentCoordinator: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loginViewController = LoginBuilder.build()
        
        loginViewController.routeToRegisterCallBack = { [weak self] in
            self?.navigateToRegister()
        }
        
        loginViewController.routeToMainFlowCallBack = { [weak self]  in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                self?.parentCoordinator?.showMainTabBarFlow()
            })
        }
        
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func navigateToRegister() {
        let registerCoordinator = RegisterCoordinator(navigationController: navigationController)
        registerCoordinator.parentCoordinator = self
        addChild(registerCoordinator)
        registerCoordinator.start()
    }
}
