import Foundation

//MARK: - ViewModel
protocol HomeViewModelProtocol {
    func loadInitialData()
    func switchCategory(to categoryId: Int)
    func loadMoreProducts(for categoryId: Int)
    func getCategories() -> [CategoryCellViewData]
    var numberOfRows: Int { get }
    var categoriesOnComplete: (() -> Void)? { get set }
    var productsOnComplete: ((ProductDataSource) -> Void)? { get set }
}

protocol HomeViewModelDelegate: AnyObject {
    func didLoseNetworkConnection()
}

//MARK: - Cells
protocol ProductCategoryCellDelegate: AnyObject {
    func productCategoryCell(_ cell: ProductCategoryCell, didTapCategoryWithId categoryId: Int)
}

protocol ProductGridCellDelegate: AnyObject {
    func productGridCell(_ cell: ProductGridCell, didTapProductWithId productId: Int)
    func productGridCell(_ cell: ProductGridCell, shouldFetchMoreProductsForCategory categoryId: Int)
}

protocol SeeAllCategoriesCellDelegate: AnyObject {
    func seeAllButtonDidTapped(_ cell: SeeAllCategoriesCell)
}
