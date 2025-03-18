import Foundation

final class HomeMappers {
    static func mapToProductCellViewData(from product: ProductDTO) -> HomeViewData.ProductCell {
        return HomeViewData.ProductCell(
            name: product.name,
            price: product.price.format(with: .currency),
            rating: "\(product.rating)",
            isFavorite: product.isFavorite,
            image: product.images.first
        )
    }
    
    static func mapToCategoryViewData(from categories: [CategoryDTO]) -> [HomeViewData.CategoryCell] {
        return categories.map { category in
            return HomeViewData.CategoryCell(
                id: category.id,
                name: category.name,
                image: category.image
            )
        }
    }
}
