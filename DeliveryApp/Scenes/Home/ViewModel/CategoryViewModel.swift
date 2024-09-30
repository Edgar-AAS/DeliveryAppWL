import Foundation

class CategoryViewData {
    private let category: ProductCategory
    
    init(category: ProductCategory) {
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
