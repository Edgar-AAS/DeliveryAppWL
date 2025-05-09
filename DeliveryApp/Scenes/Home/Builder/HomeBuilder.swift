import Foundation
import UIKit

final class HomeBuilder {
    static func build(coordinator: HomeCoordinator) -> HomeViewController {
        let httpClient: HTTPClientProtocol = HTTPClient()
        
        let keychainService: KeychainService = KeychainManager()
        let accessToken = keychainService.retrieve(key: Strings.Keychain.Keys.accessToken)
        
        let categoriesResource = ResourceModel(
            url: URL(string: "http://localhost:5177/api/categories")!,
            headers: [
                "Content-Type": "application/json",
                "Authorization": "Bearer \(accessToken ?? "")"
            ]
        )
        
        let fetchPaginatedProducts = FetchProducts(httpClient: httpClient)
        
        fetchPaginatedProducts.httpProductListResource = { resource in
            return ResourceModel(
                url: URL(string: "http://localhost:5177/api/products/\(resource.categoryId)")!,
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
        
        let fetchCategories = FetchFoodCategories(httpClient: httpClient, resource: categoriesResource)
        let viewModel = HomeViewModel(fetchCategories: fetchCategories, fetchPaginatedProducts: fetchPaginatedProducts)
        let viewController = HomeViewController(viewModel: viewModel)
        viewModel.delegate = viewController
                
        viewController.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        return viewController
    }
}
