import Foundation

final class ProductViewModel {
    private let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var name: String {
        product.name
    }
    
    var description: String {
        product.description
    }
    
    var price: String {
        product.price.currencyFormatWith(numberStyle: .currency)
    }
    
    var isFavorite: Bool {
        product.isFavorite
    }
    
    func getUrlImages() -> [ProductImage]? {
        let images = product.images
        
        guard product.images.allSatisfy({ $0.productId == product.id}) else {
            return nil
        }
        
        return images.sorted(by: { $0.id < $1.id })
    }
}
