import UIKit

final class HomeCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewController = HomeBuilder.build(coordinator: self)
        homeViewController.routeToProductDetailsPage = { [weak self] id in
            self?.navigateToProductDetails(productId: id)
        }
        
        homeViewController.routeToNetworkErrorPage =  { [weak self] in
            self?.navigateToNetworkErrorPage()
        }
        
        navigationController.setViewControllers([homeViewController], animated: false)
    }
    
    func navigateToNetworkErrorPage() {
        let networkErrorController = DANetworkErrorView()
        navigationController.present(networkErrorController, animated: true)
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
