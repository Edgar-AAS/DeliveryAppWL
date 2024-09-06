import Foundation

class HomeBuilder {
    static func build(coordinator: MainCoordinator) -> HomeViewController {
        let localData = LocalData(resource: "ProductCategories")
        let viewModel = HomeViewModel(httpClient: localData, coordinator: coordinator)
        let viewController = HomeViewController(viewModel: viewModel)
        return viewController
    }
}
