//
//  ProductCellViewModel.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 11/07/24.
//

import Foundation

class ProductCellViewModel {
    private let foodData: Food
    
    init(foodData: Food) {
        self.foodData = foodData
    }
    
    var getName: String {
        return foodData.name
    }
    
    var getformattedPrice: String {
        return foodData.price.currencyFormatWith(numberStyle: .currency)
    }
    
    var getRate: String {
        return foodData.rate
    }
    
    var getFormattedDistance: String {
        return "\(foodData.distance)m"
    }
    
    var getFavoriteImageString: String {
        return foodData.isFavorite ? "heart.fill" : "heart"
    }
    
    var getPlaceholderImageString: String {
        return "photo"
    }
    
    var getFoodImage: String {
        return foodData.image
    }
}
