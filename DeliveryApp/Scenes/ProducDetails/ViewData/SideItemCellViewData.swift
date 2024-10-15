import Foundation


final class SideItemCellViewData {
    private let sideItem: SideItem
    
    init(sideItem: SideItem) {
        self.sideItem = sideItem
    }
    
    var isSelected: Bool {
        return sideItem.isSelected
    }
    
    var name: String {
        "\(sideItem.name)"
    }
    
    var image: String {
        sideItem.imageUrl
    }
    
    var price: String {
        "+ \(sideItem.price.format(with: .currency))"
    }
}
