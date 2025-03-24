import Foundation

final class ProductDetailMapper {
    static func mapToProductHeaderViewData(_ product: ProductDTO) -> ProductDetailViewData.ProductHeaderViewData {
        .init(
            name: product.name,
            description: product.description ?? "",
            deliveryFee: product.deliveryFee?.format(with: .currency) ?? "Free Delivery",
            basePrice: product.price.format(with: .currency),
            rating: "\(product.rating)",
            images: product.images.sorted(by: { $0.id < $1.id })
        )
    }
}
