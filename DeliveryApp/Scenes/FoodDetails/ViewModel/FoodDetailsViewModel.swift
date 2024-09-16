import Foundation


protocol FoodDetailsViewModelDelegate: AnyObject {
    func stepperDidChange(dto: StepperDTO)
    func favoriteTogleWith(state: Bool)
}

protocol FoodDetailsViewModelProtocol {
    func incrementFood()
    func decrementFood()
    func isFavoriteToggle()
    func backToHome()
//    func getFoodDetailsDTO() -> FoodDetailsScreenDTO
}

class FoodDetailsViewModel: FoodDetailsViewModelProtocol {
    private var foodModel: Product
    private var stepperCount = 1

    weak var delegate: FoodDetailsViewModelDelegate?
    
    init(foodModel: Product) {
        self.foodModel = foodModel
    }
    
    func incrementFood() {
        stepperCount += 1
        updateTotalAmount()
    }
    
    func decrementFood() {
        if stepperCount != 1 {
            stepperCount -= 1
            updateTotalAmount()
        }
    }
    
    private func updateTotalAmount() {
        let totalAmount = (foodModel.price * Double(stepperCount)).currencyFormatWith(numberStyle: .currency)
        delegate?.stepperDidChange(dto: .init(count: String(stepperCount), amount: totalAmount))
    }
    
    func isFavoriteToggle() {
//        foodModel.isFavorite = !foodModel.isFavorite
//        delegate?.favoriteTogleWith(state: foodModel.isFavorite)
    }
    
    func backToHome() {
//        coordinator.eventOcurred(type: .backToHome)
    }
    
//    func getFoodDetailsDTO() -> FoodDetailsScreenDTO {
//        return FoodDetailsScreenDTO(
//            title: foodModel.name,
//            price: foodModel.price.currencyFormatWith(numberStyle: .currency),
//            deliveryFee: foodModel.deliveryFee == 0 ? "Free Delivery"
//                                                    : foodModel.deliveryFee.currencyFormatWith(numberStyle: .decimal),
//            estimatedDeliveryTime: "\(foodModel.firstDeliveryTime) - \(foodModel.secondDeliveryTime)",
//            rate: foodModel.rate,
//            description: foodModel.description,
//            quantity: String(stepperCount), 
//            isFavorite: foodModel.isFavorite,
//            image: foodModel.image)
//    }
}
