import Foundation

struct ProductItemCellViewData {
    private let name: String
    private let price: Double
    private let image: String
    let isRemovable: Bool
    
    init(name: String, price: Double, image: String, isRemovable: Bool) {
        self.name = name
        self.price = price
        self.image = image
        self.isRemovable = isRemovable
    }
    
    func getName() -> String {
        isRemovable ? "Retirar: \(name)" : "Adicionar: \(name)"
    }
    
    func getUrlImage() -> String {
        return image
    }
    
    func getPrice() -> String {
        "+ \(price.format(with: .currency))"
    }
}
