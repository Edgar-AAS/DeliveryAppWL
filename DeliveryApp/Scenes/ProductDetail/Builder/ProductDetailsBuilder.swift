import UIKit

final class ProductDetailsBuilder {
    static func build(productId: Int) -> ProductDetailsViewController {
        let keychainService: KeychainService = KeychainManager()
        let accessToken = keychainService.retrieve(key: Strings.Keychain.Keys.accessToken)

        let resource = ResourceModel(
            url: URL(string: "http://localhost:5177/api/products/details/\(productId)")!,
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
