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
struct FoodCategory: Decodable {
    let name: String
    let products: [Food]
}

// MARK: - Product
struct Food: Decodable {
    let id: String
    let rate: String
    let reviews: Int
    let distance: Int
    let firstDeliveryTime: Int
    let secondDeliveryTime: Int
    let deliveryFee: Double
    let name: String
    let price: Double
    let description: String
    let images: [String]
    let isFavorite: Bool
}
