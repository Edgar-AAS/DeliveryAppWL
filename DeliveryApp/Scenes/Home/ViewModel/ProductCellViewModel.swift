//
//  ProductCellViewModel.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 11/07/24.
//

import Foundation

class ProductCellViewModel {
    private let foodModel: Food
    
    init(foodData: Food) {
        self.foodModel = foodData
    }
    
    var getName: String {
        return foodModel.name
    }
    
    var getformattedPrice: String {
        return foodModel.price.currencyFormatWith(numberStyle: .currency)
    }
    
    var getRate: String {
        return foodModel.rate
    }
    
    var getFormattedDistance: String {
        return "\(foodModel.distance)m"
    }
    
    var getFavoriteImageString: String {
        return foodModel.isFavorite ? "heart.fill" : "heart"
    }
    
    var getFoodImage: String {
        return foodModel.image
    }
}
