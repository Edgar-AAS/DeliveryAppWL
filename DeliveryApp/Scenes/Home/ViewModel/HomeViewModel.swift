import Foundation

class HomeViewModel: HomeViewModelProtocol {
    var productsOnComplete: ((ProductGridCellDataSource) -> Void)?
    var categoriesOnComplete: (() -> Void)?
    
    private var productsDataSource = [Product]()
    private var categoriesDataSource = [ProductCategoryResponse]()
    
    private let fetchCategories: FetchProductCategoriesUseCase
    private let fetchPaginatedProducts: FetchPaginatedProductsUseCase
    
    init(fetchCategories: FetchProductCategoriesUseCase,
         fetchPaginatedProducts: FetchPaginatedProductsUseCase) {
        self.fetchCategories = fetchCategories
        self.fetchPaginatedProducts = fetchPaginatedProducts
    }
    
    var numberOfRows: Int {
        return 3
    }
    
    func getCategories() -> [CategoryCellViewData] {
        return categoriesDataSource.map { category in
            return CategoryCellViewData(
                id: category.id,
                name: category.name,
                image: category.image
            )
        }
    }
    
    func loadInitialData() {
        loadCategories { [weak self] categoriesResponse in
            guard let self = self else { return }
            self.categoriesDataSource = categoriesResponse
            self.categoriesOnComplete?()
            
            if let firstCategoryId = categoriesResponse.first?.id {
                self.loadProducts(for: firstCategoryId, resetPagination: true)
            }
        }
    }
    
    func loadMoreProducts(for categoryId: Int) {
        loadProducts(for: categoryId, resetPagination: false)
    }
    
    func switchCategory(to categoryId: Int) {
        loadProducts(for: categoryId, resetPagination: true)
    }
    
    private func loadCategories(completion: @escaping ([ProductCategoryResponse]) -> Void) {
        fetchCategories.fetch { result in
            switch result {
            case .success(let activeCategories):
                completion(activeCategories)
            case .failure(let httpError): print(httpError)
            }
        }
    }
    
    private func loadProducts(for categoryId: Int, resetPagination: Bool) {
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
