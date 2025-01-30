import Foundation
import UIKit

final class HomeBuilder {
    static func build(coordinator: HomeCoordinator) -> HomeViewController {
        let httpClient: HTTPClientProtocol = HTTPClient()
        
        let result = KeychainManager.retrieve(key: KeychainConstants.Keys.accessToken)
        var accessToken: String?
        
        switch result {
            case .failure: break
            case .success(let tokenStored):
            accessToken = tokenStored
        }
        
        let categoriesResource = ResourceModel(
            url: URL(string: "http://localhost:5177/v1/product/categories")!,
            headers: [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken ?? "")"
            ]
        )
        
        let fetchPaginatedProducts = FetchPaginatedProducts(httpClient: httpClient)
        
        fetchPaginatedProducts.httpProductListResource = { resource in
            return ResourceModel(
                url: URL(string: "http://localhost:5177/v1/product/list/\(resource.categoryId)")!,
                method: .get([
                    URLQueryItem(name: "page", value: "\(resource.currentPage)"),
                    URLQueryItem(name: "pageSize", value: "\(resource.pageSize)")
                ]),
                headers: [
                    "Content-Type": "application/json",
                    "Authorization": "Bearer \(accessToken ?? "")"
                ]
            )
        }
        
        let fetchCategories = FetchProductCategories(httpClient: httpClient, resource: categoriesResource)
        let viewModel = HomeViewModel(fetchCategories: fetchCategories, fetchPaginatedProducts: fetchPaginatedProducts)
        let viewController = HomeViewController(viewModel: viewModel)
        
        viewController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        return viewController
    }
}
