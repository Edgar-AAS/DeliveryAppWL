import Foundation

struct ProductDTO: Codable {
    let id: Int
    let name: String
    let price: Double
    let discountPrice: Double?
    let rating: Float
    let deliveryFee: Double?
    let description: String?
    let isFavorite: Bool
    let images: [ProductImageDTO]
    let sections: [SectionDTO]
}
