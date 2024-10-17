import Foundation

struct HeaderViewData {
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
    
    func getName() -> String {
        return name
    }
    
    func getBasePrice() -> String {
        return basePrice.format(with: .currency)
    }
    
    func getDeliveryFee() -> String {
        return deliveryFee?.format(with: .currency) ?? "Free Delivery"
    }
    
    func getRating() -> String {
        return String(rating)
    }
    
    func getDescription() -> String {
        return description
    }
    
    func getImages() -> [ProductImage] {
        return images
    }
    
    func getPrefixBasePrice() -> String {
        return "A partir de "
    }
}
