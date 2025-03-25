import Foundation

//MARK: - ViewModel
protocol HomeViewModelProtocol {
    func loadProductsToInitialCategory()
    func switchCategory(to categoryId: Int)
    func loadMoreProducts(for categoryId: Int)
    func getCategories() -> [HomeViewData.CategoryCellViewData]
    func getHomeCellTypeIn(row: Int) -> HomeCellsType
    var numberOfRows: Int { get }
    var categoriesOnComplete: (() -> Void)? { get set }
    var loadProductsOnComplete: ((HomeViewData.ProductCellViewData) -> Void)? { get set }
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
    func productGridCell(_ cell: ProductGridCell, shouldFetchMoreProductsToCategory categoryId: Int)
}
