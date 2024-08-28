//
//  HomeViewModel.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 24/04/24.
//

import Foundation


enum FoodCategoryType: String {
    case burger = "Burger"
    case pizza = "Pizza"
    case drink = "Drink"
    case taco = "Taco"
}

protocol HomeViewModelProtocol {
    func fetchFoodsBy(category: FoodCategoryType, completion: @escaping ([Food], [FoodCategoryDTO]) -> Void)
    func goToDetailsScreen(food: Food)
    var numberOfRows: Int { get }
}

class HomeViewModel: HomeViewModelProtocol {
    var loadingHandler: ((Bool) -> ())?
    
    private let httpGetService: HttpGet
    private let coordinator: Coordinator
    
    init(httpGetService: HttpGet, coordinator: Coordinator) {
        self.httpGetService = httpGetService
        self.coordinator = coordinator
    }
    
    var numberOfRows: Int {
        return 2
    }
    
    func fetchFoodsBy(category: FoodCategoryType = .burger, completion: @escaping ([Food], [FoodCategoryDTO]) -> Void) {
        httpGetService.get(with: URL(string: "any_url")!) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let foodData):
                if let foods: ProductCategories = foodData?.toModel(),
                   let foodsByCategory = foods.categories
                                        .filter({$0.name == category.rawValue})
                                        .first?.products
                {
                    let categories = foods.categories
                                    .map { FoodCategoryDTO(name: $0.name, image: $0.image) }
                    
                    DispatchQueue.main.async {
                        completion(foodsByCategory, categories)
                    }
                }
            case .failure(let error):
                switch error {
                case .noConnectivity:
                    DispatchQueue.main.async {
                        print("ERROR SCREEN HANDLE")
                    }
                default: return
                }
            }
        }
    }
    
    func goToDetailsScreen(food: Food) {
        coordinator.eventOcurred(type: .goToFoodDetails(food))
    }
}
