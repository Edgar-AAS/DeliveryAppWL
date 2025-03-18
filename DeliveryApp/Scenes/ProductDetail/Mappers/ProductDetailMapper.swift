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
    
    static func mapToSideItem(item: ItemDTO, isSelected: Bool) -> SideItem {
        .init(
            id: item.id,
            name: item.name,
            price: item.price,
            imageUrl: item.imageUrl,
            quantity: item.quantity,
            isSelected: isSelected
        )
    }
    
    static func mapToSideItemCellViewData(sideItem: SideItem) -> ProductDetailViewData.SideItemCellViewData {
        return ProductDetailViewData.SideItemCellViewData(
            name: sideItem.name,
            price:  "+ \(sideItem.price.format(with: .currency))",
            image: sideItem.imageUrl,
            isSelected: sideItem.isSelected
        )
    }
    
    static func mapToQuantitativeItem(item: ItemDTO, isRemovable: Bool) -> ProductDetailViewData.QuantitativeItemViewData {
        .init(
            name: isRemovable ? "Retirar: \(item.name)" : "Adicionar: \(item.name)",
            price: "+ \(item.price.format(with: .currency))",
            image: item.imageUrl,
            isRemovable: isRemovable
        )
    }
}
