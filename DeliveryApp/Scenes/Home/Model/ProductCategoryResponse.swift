import Foundation

struct ProductCategoryResponse: Codable {
    let id: Int
    let name: String
    let isActive: Bool
    let description: String
    let image: String?
}