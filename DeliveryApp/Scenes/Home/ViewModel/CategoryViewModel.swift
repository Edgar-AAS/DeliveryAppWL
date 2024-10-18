import Foundation

class CategoryViewData {
    private let category: ProductCategoryResponse
    
    init(category: ProductCategoryResponse) {
        self.category = category
    }
    
    var name: String {
        category.name
    }
    
    var description: String {
        category.description
    }
    
    var image: String? {
        category.image
    }
}
