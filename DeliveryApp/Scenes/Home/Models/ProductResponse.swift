struct ProductResponse: Codable {
    let total: Int
    let page: Int
    let pageSize: Int
    let products: [Product]
}

struct Product: Codable {
    let id: Int
    let name: String
    let price: Double
    let discountPrice: Double?
    let rating: Float
    let deliveryFee: Double?
    let description: String?
    let isFavorite: Bool
    let images: [ProductImage]
    let sections: [Section]
}

struct Section: Codable {
    let name: String
    let isActive: Bool
    let isRequired: Bool
    let isSideItem: Bool
    let isRemovable: Bool
    let limitOptions: Int
    let selectionOrder: Int
    var items: [Item]
}

struct Item: Codable {
    let id: Int
    let name: String
    let price: Double
    var quantity: Int
    let imageUrl: String?
}

struct ProductImage: Codable {
    let id: Int
    let url: String
}

struct ProductCategory: Codable {
    let id: Int
    let name: String
    let isActive: Bool
    let description: String
    let image: String?
}

//MAARK: - Mappers
extension Product {
    func mapToProductHeaderViewData() -> ProductHeaderViewData {
        .init(
            name: name,
            description: description ?? "",
            deliveryFee: deliveryFee?.format(with: .currency) ?? "Free Delivery",
            basePrice: price.format(with: .currency),
            rating: "\(rating)",
            images: images.sorted(by: { $0.id < $1.id })
        )
    }
    
    func mapToProductCellViewData() -> ProductCellViewData {
        return ProductCellViewData(
            name: name,
            price: price.format(with: .currency),
            rating: "\(rating)",
            isFavorite: isFavorite,
            image: images.first
        )
    }
}

extension Item {
    func mapToSideItem(isSelected: Bool) -> SideItem {
        .init(
            id: id,
            name: name,
            price: price,
            imageUrl: imageUrl,
            quantity: quantity,
            isSelected: isSelected
        )
    }
    
    func mapToQuantitativeItem(isRemovable: Bool) -> QuantitativeItemViewData {
        .init(
            name: isRemovable ? "Retirar: \(name)" : "Adicionar: \(name)",
            price: "+ \(price.format(with: .currency))",
            image: imageUrl,
            isRemovable: isRemovable
        )
    }
}

extension ProductCategory {
    func mapToCategoryViewData() -> CategoryCellViewData {
        return CategoryCellViewData(
            id: id,
            name: name,
            image: image
        )
    }
}

