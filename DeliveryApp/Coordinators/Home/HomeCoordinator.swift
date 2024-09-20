import UIKit

class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewController = HomeBuilder.build(coordinator: self)
        navigationController.setViewControllers([homeViewController], animated: false)
    }
}
