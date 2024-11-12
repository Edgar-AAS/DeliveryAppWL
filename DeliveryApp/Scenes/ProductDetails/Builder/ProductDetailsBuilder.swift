import UIKit

class ProductDetailsBuilder {
    static func build(productId: Int) -> ProductDetailsViewController {
        let resource = ResourceModel(
            url: URL(string: "http://localhost:5177/v1/products/details/\(productId)")!,
            headers: ["Content-Type": "application/json"]
        )
        
        let httpClient: HTTPClientProtocol = HTTPClient()
        let fetchDetails = FetchProductDetails(httpClient: httpClient, resource: resource)
        let viewModel = ProductDetailsViewModel(fetchDetails: fetchDetails)
        let viewController = ProductDetailsViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        return viewController
    }
}
