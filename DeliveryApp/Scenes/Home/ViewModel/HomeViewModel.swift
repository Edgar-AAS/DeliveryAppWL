import Foundation

class HomeViewModel: HomeViewModelProtocol {
    var productsOnComplete: ((ProductGridCellDataSource) -> Void)?
    var categoriesOnComplete: (() -> Void)?
    
    private var products = [Product]()
    private var categories = [CategoryResponse]()
    
    private let fetchCategories: FetchProductCategoriesUseCase
    private let fetchPaginatedProducts: FetchPaginatedProductsUseCase
    
    init(fetchCategories: FetchProductCategoriesUseCase, fetchPaginatedProducts: FetchPaginatedProductsUseCase) {
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
    
    func getCategories() -> [CategoryCellViewData] {
        return categories.map { category in
            return category.toCategoryCellViewData()
        }
    }
    
    func loadMoreProducts(for categoryId: Int) {
        loadProducts(by: categoryId, resetPagination: false)
    }
    
    func switchCategory(to categoryId: Int) {
        loadProducts(by: categoryId, resetPagination: true)
    }
    
    private func loadCategories(completion: @escaping ([CategoryResponse]) -> Void) {
        fetchCategories.fetch { result in
            switch result {
            case .success(let activeCategories):
                completion(activeCategories)
            case .failure(let httpError): print(httpError)
            }
        }
    }
    
    private func loadProducts(by categoryId: Int, resetPagination: Bool) {
        fetchPaginatedProducts.fetch(for: categoryId, resetPagination: resetPagination) { [weak self] result in
            switch result {
            case .success(let productsPaginated):
                let dataSource = ProductGridCellDataSource(categoryId: categoryId, products: productsPaginated)
                self?.productsOnComplete?(dataSource)
            case .failure(let httpError):
                print(httpError)
            }
        }
    }
}
