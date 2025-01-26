struct ProductResponse: Codable {
    let total: Int
    let page: Int
    let pageSize: Int
    let products: [Product]
}

struct Product: Codable {
    let id: Int
    let name: String
    let price: Double
    let discountPrice: Double?
    let rating: Float
    let deliveryFee: Double?
    let description: String?
    let isFavorite: Bool
    let images: [ProductImage]
}

struct ProductImage: Codable {
    let id: Int
    let url: String
}

struct CategoryResponse: Codable {
    let id: Int
    let name: String
    let isActive: Bool
    let description: String
    let image: String?
}
