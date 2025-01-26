import Foundation

struct ProductDetailsResponse: Codable {
    let id: Int
    let name: String
    let price: Double
    let rating: Float
    let deliveryFee: Double?
    let discountPrice: Double?
    let description: String
    let isFavorite: Bool
    let sections: [Section]
    let images: [ProductImage]
}

struct Section: Codable {
    let name: String
    let isActive: Bool
    let isRequired: Bool
    let isSideItem: Bool
    let isRemovable: Bool
    let limitOptions: Int
    let selectionOrder: Int
    var items: [Item]
}

struct Item: Codable {
    let id: Int
    let name: String
    let price: Double
    var quantity: Int
    let imageUrl: String?
}
