import Foundation

final class HeaderViewData {
    private let productDatailsResponse: ProductDetailsResponse
    
    init(productDatailsResponse: ProductDetailsResponse) {
        self.productDatailsResponse = productDatailsResponse
    }
    
    var name: String {
        productDatailsResponse.name
    }
    
    
    var prefixBasePrice: String {
        "A partir de "
    }
    
    var basePrice: String {
        productDatailsResponse.price.format(with: .currency)
    }
    
    var deliveryFee: String {
        productDatailsResponse.deliveryFee?.format(with: .currency) ?? "Free Delivery"
    }
    
    var rating: String {
        "\(productDatailsResponse.rating)"
    }
    
    var isFavorite: Bool {
        productDatailsResponse.isFavorite
    }
    
    var description: String {
        productDatailsResponse.description
    }
    
    var images: [ProductImage]? {
        productDatailsResponse.images
    }
}
