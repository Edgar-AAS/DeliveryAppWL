import UIKit

class FoodDetailsBuilder {
    static func build(coordinator: MainCoordinator, foodModel: Food) -> FoodDetailsViewController {
        let viewModel = FoodDetailsViewModel(foodModel: foodModel, coordinator: coordinator)
        let viewController = FoodDetailsViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        return viewController
    }
}
