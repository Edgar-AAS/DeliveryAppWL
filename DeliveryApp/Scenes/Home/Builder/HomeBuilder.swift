import Foundation
import UIKit

class HomeBuilder {
    static func build(coordinator: HomeCoordinator) -> HomeViewController {
        let httpClient: HTTPClientProtocol = HTTPClient()
        
        let categoriesResource = Resource(
            url: URL(string: "http://localhost:5177/v1/categories")!,
            headers: ["Content-Type": "application/json"],
            modelType: [ProductCategoryResponse].self
        )
        
        let fetchPaginatedProducts = FetchPaginatedProducts(httpClient: httpClient)
        
        fetchPaginatedProducts.resourceCallBack = { resource in
            return Resource(
                url: URL(string: "http://localhost:5177/v1/products/category/\(resource.categoryId)")!,
                method: .get([
                    URLQueryItem(name: "page", value: "\(resource.currentPage)"),
                    URLQueryItem(name: "pageSize", value: "\(resource.pageSize)")
                ]),
                headers: ["Content-Type": "application/json"],
                modelType: ProductResponse.self
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
