import Foundation

struct ItemDTO: Codable {
    let id: Int
    let name: String
    let price: Double
    let imageUrl: String?
}
