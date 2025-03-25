import Foundation

enum ProductItemType {
    case selectableItem(ProductDetailViewData.SelectableItemViewData)
    case quantitativeItem(ProductDetailViewData.QuantitativeItemViewData)
    case unknown
}
