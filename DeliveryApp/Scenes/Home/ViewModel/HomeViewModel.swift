import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    var productsOnComplete: ((ProductDataSource) -> Void)?
    var categoriesOnComplete: (() -> Void)?
    
    weak var delegate: HomeViewModelDelegate?

    private var products = [ProductDTO]()
    private var categories = [CategoryDTO]()
    
    private let fetchCategories: FetchFoodCategories
    private let fetchPaginatedProducts: FetchProductsUseCase
    
    init(fetchCategories: FetchFoodCategories,
         fetchPaginatedProducts: FetchProductsUseCase) {
        self.fetchCategories = fetchCategories
        self.fetchPaginatedProducts = fetchPaginatedProducts
    }
    
    var numberOfRows: Int {
        return 3
    }
    
    func loadInitialData() {
        loadCategories { [weak self] categoriesResponse in
            guard let self = self else { return }
            
            self.categories = categoriesResponse
            self.categoriesOnComplete?()
            
            if let firstCategoryId = categoriesResponse.first?.id {
                self.loadProducts(by: firstCategoryId, resetPagination: true)
            }
        }
    }
    
    func getCategories() -> [HomeViewData.CategoryCell] {
        return HomeMappers.mapToCategoryViewData(from: categories)
    }
    
    func loadMoreProducts(for categoryId: Int) {
        loadProducts(by: categoryId, resetPagination: false)
    }
    
    func switchCategory(to categoryId: Int) {
        loadProducts(by: categoryId, resetPagination: true)
    }
    
    private func loadCategories(completion: @escaping ([CategoryDTO]) -> Void) {
        fetchCategories.fetch { result in
            switch result {
            case .success(let activeCategories):
                completion(activeCategories)
            case .failure(let httpError):
                print(httpError)
            }
        }
    }
    
    private func loadProducts(by categoryId: Int, resetPagination: Bool) {
        fetchPaginatedProducts.fetch(for: categoryId, resetPagination: resetPagination) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let productsPaginated):
                let dataSource = ProductDataSource(categoryId: categoryId, products: productsPaginated)
                self.productsOnComplete?(dataSource)
            case .failure(let httpError):
                switch httpError {
                case .noConnectivity:
                    self.delegate?.didLoseNetworkConnection()
                default:
                    print(httpError)
                }
            }
        }
    }
}
