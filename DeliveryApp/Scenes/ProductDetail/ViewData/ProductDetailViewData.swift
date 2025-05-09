import Foundation


struct ProductDetailViewData {
    struct ProductHeaderViewData {
        let name: String
        let description: String?
        let deliveryFee: String
        let basePrice: String
        let rating: String
        let images: [ProductImageDTO]
    }
    
    struct SelectableItemViewData {
        let name: String
        let price: String
        let image: String?
        let isSelected: Bool
    }
    
    struct QuantitativeItemViewData {
        let name: String
        let price: String
        let image: String?
        let isRemovable: Bool
        let stepperModel: StepperModel
    }
    
    struct SectionHeaderViewData {
        let name: String
        let isRequired: Bool
        let limitOptions: Int
        
        var requiredText: String {
            return "OBRIGATÓRIO"
        }
      
        var sectionOptionsLimit: String {
            "Escolha até \(limitOptions) opções."
        }
    }
}

