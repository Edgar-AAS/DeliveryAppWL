import Foundation

struct ProductCategory: Codable {
    let id: Int
    let name: String
    let isActive: Bool
    let description: String
    let image: String?
    
    init(id: Int, name: String, isActive: Bool, description: String, image: String) {
        self.id = id
        self.name = name
        self.isActive = isActive
        self.description = description
        self.image = image
    }
}
