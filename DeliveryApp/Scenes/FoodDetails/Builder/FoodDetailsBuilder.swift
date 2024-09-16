import UIKit

class FoodDetailsBuilder {
    static func build(foodModel: Product) -> FoodDetailsViewController {
        let viewModel = FoodDetailsViewModel(foodModel: foodModel)
        let viewController = FoodDetailsViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        return viewController
    }
}
