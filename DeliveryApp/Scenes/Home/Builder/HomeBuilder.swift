import Foundation
import UIKit

class HomeBuilder {
    static func build(coordinator: HomeCoordinator) -> HomeViewController {
        let httpClient: HTTPClientProtocol = HTTPClient()
        
        let categoriesResource = ResourceModel(
            url: URL(string: "http://localhost:5177/v1/categories")!,
            headers: ["Content-Type": "application/json"]
        )
        
        let fetchPaginatedProducts = FetchPaginatedProducts(httpClient: httpClient)
        
        fetchPaginatedProducts.productsResponseCallBack = { resource in
            return ResourceModel(
                url: URL(string: "http://localhost:5177/v1/products/category/\(resource.categoryId)")!,
                method: .get([
                    URLQueryItem(name: "page", value: "\(resource.currentPage)"),
                    URLQueryItem(name: "pageSize", value: "\(resource.pageSize)")
                ]),
                headers: ["Content-Type": "application/json"]
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
