//
//  Food.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 24/04/24.
//

import Foundation

struct ProductCategories: Decodable {
    let categories: [FoodCategory]
}

// MARK: - Category
struct FoodCategory: Decodable, Equatable {
    let name: String
    let image: String
    let products: [Food]
}

// MARK: - Product
struct Food: Decodable, Equatable {
    let id: String
    let rate: String
    let reviews: Int
    let distance: Int
    let firstDeliveryTime: String
    let secondDeliveryTime: String
    let deliveryFee: Double
    let name: String
    let price: Double
    let description: String
    let image: String
    var isFavorite: Bool
}
