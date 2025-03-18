import Foundation

struct HomeViewData {
    struct ProductCell {
        let name: String
        let price: String
        let rating: String
        let isFavorite: Bool
        let image: ProductImageDTO?
    }
    
    struct CategoryCell {
        let id: Int
        let name: String
        let image: String?
    }
}
