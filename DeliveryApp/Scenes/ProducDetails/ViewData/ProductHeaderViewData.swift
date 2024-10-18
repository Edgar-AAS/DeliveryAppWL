import Foundation

struct ProductHeaderViewData {
    private let name: String
    private let description: String
    private let basePrice: Double
    private let deliveryFee: Double?
    private let rating: Float
    private let images: [ProductImage]
    
    init(name: String, description: String, basePrice: Double, deliveryFee: Double?, rating: Float, images: [ProductImage]) {
        self.name = name
        self.description = description
        self.basePrice = basePrice
        self.deliveryFee = deliveryFee
        self.rating = rating
        self.images = images
    }
    
    var displayName: String {
        return name
    }
    
    var formattedBasePrice: String {
        return basePrice.format(with: .currency)
    }
    
    var displayDeliveryFee: String {
        return deliveryFee?.format(with: .currency) ?? "Free Delivery"
    }
    
    var stringRating: String {
        return "\(rating)"
    }
    
    var displayDescription: String {
        return description
    }
    
    func sortedImages() -> [ProductImage] {
        return images.sorted(by: { $0.id < $1.id })
    }
    
    var prefixBasePrice: String {
        return "A partir de "
    }
}
