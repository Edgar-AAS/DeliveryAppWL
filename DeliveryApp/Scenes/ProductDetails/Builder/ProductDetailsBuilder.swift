import UIKit

final class ProductDetailsBuilder {
    static func build(productId: Int) -> ProductDetailsViewController {
        let result = KeychainManager.retrieve(key: KeychainConstants.Keys.accessToken)
        var accessToken: String?
        
        switch result {
            case .failure: break
            case .success(let tokenStored):
            accessToken = tokenStored
        }
        
        let resource = ResourceModel(
            url: URL(string: "http://localhost:5177/v1/product/details/\(productId)")!,
            headers: [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken ?? "")"
            ]
        )
        
        let httpClient: HTTPClientProtocol = HTTPClient()
        let fetchDetails = FetchProductDetails(httpClient: httpClient, resource: resource)
        let viewModel = ProductDetailsViewModel(fetchDetails: fetchDetails)
        let viewController = ProductDetailsViewController(viewModel: viewModel)
        viewModel.delegate = viewController
        return viewController
    }
}
