import Foundation

protocol HomeViewModelProtocol {
    func loadInitialData()
    func switchCategory(to categoryId: Int)
    func loadMoreProducts(for categoryId: Int)
    func getCategories() -> [CategoryCellViewData]
    var numberOfRows: Int { get }
    var categoriesOnComplete: (() -> Void)? { get set }
    var productsOnComplete: ((ProductGridCellDataSource) -> Void)? { get set }
}

protocol HomeViewModelDelegate: AnyObject {
    func didLoseNetworkConnection()
}

protocol FetchProductCategoriesUseCase {
    func fetch(completion: @escaping (Result<[CategoryResponse], HTTPError>) -> Void)
}

protocol FetchPaginatedProductsUseCase {
    func fetch(for categoryId: Int, resetPagination: Bool, completion: @escaping (Result<[Product], HTTPError>) -> Void)
}

protocol ProductCategoryCellDelegate: AnyObject {
    func productCategoryCell(_ cell: ProductCategoryCell, didTapCategoryWithId categoryId: Int)
}

protocol ProductGridCellDelegate: AnyObject {
    func productGridCell(_ cell: ProductGridCell, didTapProductWithId productId: Int)
    func productGridCell(_ cell: ProductGridCell, shouldFetchMoreProductsForCategory categoryId: Int)
}
