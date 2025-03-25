import Foundation

final class HomeViewModel: HomeViewModelProtocol {
    var loadProductsOnComplete: ((HomeViewData.ProductCellViewData) -> Void)?
    var categoriesOnComplete: (() -> Void)?
    
    weak var delegate: HomeViewModelDelegate?
    
    private var products = [ProductDTO]()
    private var categories = [CategoryDTO]()
    
    private let fetchFoodCategoriesUseCase: FetchFoodCategoriesUseCase
    private let fetchProductsUseCase: FetchProductsUseCase
    
    init(fetchCategories: FetchFoodCategories, fetchPaginatedProducts: FetchProductsUseCase) {
        self.fetchFoodCategoriesUseCase = fetchCategories
        self.fetchProductsUseCase = fetchPaginatedProducts
    }
    
    private let selectionOrder: [HomeCellsType] = [
        .seeAll,
        .categories,
        .products
    ]
    
    var numberOfRows: Int {
        return selectionOrder.count
    }
    
    func getHomeCellTypeIn(row: Int) -> HomeCellsType {
        return selectionOrder[row]
    }
    
    func loadProductsToInitialCategory() {
        loadCategories { [weak self] categoriesResponse in
            guard let self = self else { return }
            
            self.categories = categoriesResponse
            self.categoriesOnComplete?()
            
            if let firstCategoryId = categoriesResponse.first?.id {
                self.loadProducts(by: firstCategoryId, resetPagination: true)
            }
        }
    }
    
    func getCategories() -> [HomeViewData.CategoryCellViewData] {
        return categories.map { category in
            return HomeViewData.CategoryCellViewData(
                id: category.id,
                name: category.name,
                image: category.image
            )
        }
    }
    
    func loadMoreProducts(for categoryId: Int) {
        loadProducts(by: categoryId, resetPagination: false)
    }
    
    func switchCategory(to categoryId: Int) {
        loadProducts(by: categoryId, resetPagination: true)
    }
    
    private func loadCategories(completion: @escaping ([CategoryDTO]) -> Void) {
        fetchFoodCategoriesUseCase.fetch { result in
            switch result {
            case .success(let activeCategories):
                completion(activeCategories)
            case .failure(let httpError):
                print(httpError)
            }
        }
    }
    
    private func loadProducts(by categoryId: Int, resetPagination: Bool) {
        fetchProductsUseCase.fetch(for: categoryId, resetPagination: resetPagination) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let productsPaginated):
                let viewData = mapToProductCellViewData(from: productsPaginated, in: categoryId)
                self.loadProductsOnComplete?(viewData)
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
    
    
    private func mapToProductCellViewData(from products: [ProductDTO], in categoryId: Int) -> HomeViewData.ProductCellViewData {
        return HomeViewData.ProductCellViewData(
            categoryId: categoryId,
            products: products.map( {
                return HomeViewData.ProductViewData(
                    id: $0.id,
                    name: $0.name,
                    price: $0.price.format(with: .currency),
                    rating: "\($0.rating)",
                    isFavorite: $0.isFavorite,
                    image: $0.images.first!)
            } )
        )
    }
}
