import Foundation

struct ProductPaginatedResponseDTO: Codable {
    let total: Int
    let page: Int
    let pageSize: Int
    let products: [ProductDTO]
}
