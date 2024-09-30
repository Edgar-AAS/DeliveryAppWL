import Foundation
import UIKit

class HomeBuilder {
    static func build(coordinator: HomeCoordinator) -> HomeViewController {
        let httpClient: HTTPClientProtocol = HTTPClient()
        let viewModel = HomeViewModel(httpClient: httpClient)
        let viewController = HomeViewController(viewModel: viewModel)
        viewController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        return viewController
    }
}
