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
    var foodDataSource: Observable<([Food], [String])> { get }
    func fetchFoodsBy(category: FoodCategoryType, completion: @escaping ([Food], [String]) -> Void)
    func goToDetailsScreen(food: Food)
    var numberOfRows: Int { get }
}

class HomeViewModel: HomeViewModelProtocol {
    private let httpGetService: HtttpGetClientProtocol
    private let coordinator: Coordinator
    var foodDataSource: Observable<([Food], [String])> = Observable(value: ([], []))
    
    init(httpGetService: HtttpGetClientProtocol, coordinator: Coordinator) {
        self.httpGetService = httpGetService
        self.coordinator = coordinator
    }
    
    var numberOfRows: Int {
        return 2
    }
    
    func fetchFoodsBy(category: FoodCategoryType, completion: @escaping ([Food], [String]) -> Void) {
        httpGetService.get(with: URL(string: "any_url")!) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let foodData):
                if let foods: ProductCategories = foodData?.toModel(),
                   let foodByCategory = foods.categories.filter({$0.name == category.rawValue}).first?.products {
                   let categoryNames = foods.categories.map { $0.name }
                    
                    DispatchQueue.main.async {
                        completion(foodByCategory, categoryNames)
                    }
                } else {
                    print("decoding error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func goToDetailsScreen(food: Food) {
        coordinator.eventOcurred(type: .goToFoodDetails(food))
    }
}

extension Data {
    func toModel<T: Decodable>() -> T? {
        guard let data = try? JSONDecoder().decode(T.self, from: self) else {
            return nil
        }
        return data
    }
}
