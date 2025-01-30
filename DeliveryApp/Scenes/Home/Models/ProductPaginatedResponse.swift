struct ProductPaginatedResponse: Codable {
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
    
    func mapToProductHeaderViewData() -> ProductHeaderViewData {
        .init(
            name: name,
            description: description ?? "",
            basePrice: price,
            deliveryFee: deliveryFee,
            rating: rating,
            images: images
        )
    }
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

struct ProductImage: Codable {
    let id: Int
    let url: String
}

struct CategoryResponse: Codable {
    let id: Int
    let name: String
    let isActive: Bool
    let description: String
    let image: String?
    
    func toCategoryCellViewData() -> CategoryCellViewData {
        return CategoryCellViewData(
            id: id,
            name: name,
            image: image
        )
    }
}
