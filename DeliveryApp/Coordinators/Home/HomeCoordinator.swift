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
        homeViewController.productDetailsCallback = { [weak self] id in
            self?.navigateToProductDetails(productId: id)
        }
        navigationController.setViewControllers([homeViewController], animated: false)
    }
    
    func navigateToProductDetails(productId: Int) {
        let productDetailsViewController = ProductDetailsBuilder.build(productId: productId)
        navigationController.present(productDetailsViewController, animated: true)
    }
}
