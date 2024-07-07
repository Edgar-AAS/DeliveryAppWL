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
}

protocol HomeViewModelProtocol {
    var foodDataSource: Observable<[Food]> { get }
    func fetchFoodsBy(category: FoodCategoryType)
    var numberOfRows: Int { get }
}

class HomeViewModel: HomeViewModelProtocol {
    private let httpGetService: HtttpGetClientProtocol
    var foodDataSource: Observable<[Food]> = Observable(value: [])
    
    
    init(httpGetService: HtttpGetClientProtocol) {
        self.httpGetService = httpGetService
    }
    
    var numberOfRows: Int {
        return 2
    }

    func fetchFoodsBy(category: FoodCategoryType) {
        httpGetService.get(with: URL(string: "any_url")!) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let foodData):
                if let foods: ProductCategories = foodData?.toModel(),
                   let foodByCategory = foods.categories.filter({$0.name == category.rawValue}).first?.products {
                    DispatchQueue.main.async {
                        self?.foodDataSource.setValue(foodByCategory)
                    }
                } else {
                    print("decoding error")
                }
            case .failure(let error):
                print(error)
            }
        }
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
