import Foundation

class ProductDetailsViewData {
    private let productDetails: ProductDetailsResponse
    
    init(productDetails: ProductDetailsResponse) {
        self.productDetails = productDetails
    }
    
    var name: String {
        productDetails.name
    }
    
    var price: String {
        productDetails.price.format(with: .currency)
    }
    
    var rating: String {
        "\(productDetails.rating)"
    }
    
    var isFavorite: Bool {
        productDetails.isFavorite
    }
    
    var description: String {
        productDetails.description
    }
    
    func getUrlImages() -> [ProductImage]? {
        let images = productDetails.images
        return images.sorted(by: { $0.id < $1.id })
    }
}
