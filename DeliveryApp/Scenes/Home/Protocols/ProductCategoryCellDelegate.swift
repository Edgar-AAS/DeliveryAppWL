import Foundation

protocol ProductCategoryCellDelegate: AnyObject {
    func productCategoryCell(_ cell: ProductCategoryCell, didTapCategoryWithId categoryId: Int)
}
