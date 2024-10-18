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
