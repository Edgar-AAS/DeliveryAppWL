import Foundation

struct ProductCellViewData {
    private let name: String
    private let price: Double
    private let rating: Float
    private let isFavorite: Bool
    private let images: [ProductImage]?
    
    init(name: String, price: Double, rating: Float, isFavorite: Bool, images: [ProductImage]?) {
        self.name = name
        self.price = price
        self.rating = rating
        self.isFavorite = isFavorite
        self.images = images
    }
    
    var displayName: String {
        return name
    }
    
    var formattedPrice: String {
        return price.format(with: .currency)
    }
    
    var stringRating: String {
        return "\(rating)"
    }
    
    var favoriteStatus: Bool {
        return isFavorite
    }
    
    func sortedImages() -> [ProductImage]? {
        return images?.sorted(by: { $0.id < $1.id })
    }
}
