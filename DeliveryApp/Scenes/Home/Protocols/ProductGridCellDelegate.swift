import Foundation

protocol ProductGridCellDelegate: AnyObject {
    func productGridCell(_ cell: ProductGridCell, didTapProductWithId productId: Int)
    func productGridCell(_ cell: ProductGridCell, shouldFetchMoreProductsForCategory categoryId: Int)
}
