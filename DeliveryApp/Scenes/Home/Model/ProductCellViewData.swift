import Foundation

final class ProductCellViewData {
    private let product: Product
        
    init(product: Product) {
        self.product = product
    }
    
    var name: String {
        product.name
    }
    
    var price: String {
        product.price.format(with: .currency)
    }
    
    var rating: String {
        "\(product.rating)"
    }
    
    var isFavorite: Bool {
        product.isFavorite
    }
    
    func getUrlImages() -> [ProductImage]? {
        let images = product.images
        return images.sorted(by: { $0.id < $1.id })
    }
}
