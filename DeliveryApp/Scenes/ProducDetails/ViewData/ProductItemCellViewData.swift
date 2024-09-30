import Foundation

class ProductItemCellViewData {
    private let item: Item
    
    init(item: Item) {
        self.item = item
    }
    
    var name: String {
        "Adicionar: \(item.name)"
    }
    
    var image: String {
        item.imageUrl
    }
    
    var price: String {
        "+ \(item.price.format(with: .currency))"
    }
}
