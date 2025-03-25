import Foundation

struct HomeViewData {
    struct ProductCellViewData {
        let categoryId: Int
        let products: [ProductViewData]
    }
    
    struct CategoryCellViewData {
        let id: Int
        let name: String
        let image: String?
    }
    
    struct ProductViewData {
        let id: Int
        let name: String
        let price: String
        let rating: String
        let isFavorite: Bool
        let image: ProductImageDTO?
    }
}

