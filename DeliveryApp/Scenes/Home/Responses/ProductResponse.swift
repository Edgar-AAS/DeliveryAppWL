struct ProductResponse: Codable {
    let total: Int
    let products: [Product]
}

struct Product: Codable {
    let id: Int
    let categoryId: Int
    let name: String
    let price: Double
    let rating: Float
    let isFavorite: Bool
    let images: [ProductImage]
}

struct ProductImage: Codable {
    let id: Int
    let url: String
}
