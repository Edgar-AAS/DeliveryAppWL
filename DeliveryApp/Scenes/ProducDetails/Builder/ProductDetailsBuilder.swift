import UIKit

class ProductDetailsBuilder {
    static func build(productId: Int) -> ProductDetailsViewController {
        let httpClient: HTTPClientProtocol = HTTPClient()
        let viewModel = ProductDetailsViewModel(httpClient: httpClient, productId: productId)
        let viewController = ProductDetailsViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        return viewController
    }
}
