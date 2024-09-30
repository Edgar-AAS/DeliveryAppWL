import Foundation


final class SideItemCellViewData {
    private let item: Item
    let isSelected: Bool
    
    init(item: Item, isSelected: Bool) {
        self.item = item
        self.isSelected = isSelected
    }
    
    var name: String {
        "\(item.name)"
    }
    
    var image: String {
        item.imageUrl
    }
    
    var price: String {
        "+ \(item.price.format(with: .currency))"
    }
}
