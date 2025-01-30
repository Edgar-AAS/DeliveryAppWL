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
        homeViewController.productCardBlock = { [weak self] id in
            self?.navigateToProductDetails(productId: id)
        }
        navigationController.setViewControllers([homeViewController], animated: false)
    }
    
    func navigateToProductDetails(productId: Int) {
        let productsDetailsController = ProductDetailsBuilder.build(productId: productId)
        
        productsDetailsController.backToHome  = { [weak self] in
            self?.navigateToHome()
        }
        navigationController.present(productsDetailsController, animated: true)
    }
    
    func navigateToHome() {
        navigationController.dismiss(animated: true)
    }
}
