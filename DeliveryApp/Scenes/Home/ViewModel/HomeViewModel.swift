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
    private let httpClient: HTTPClientProtocol
    private let coordinator: Coordinator
    
    init(httpClient: HTTPClientProtocol, coordinator: Coordinator) {
        self.httpClient = httpClient
        self.coordinator = coordinator
    }
    
    var numberOfRows: Int {
        return 2
    }
    
    func fetchFoodsBy(category: FoodCategoryType = .burger, completion: @escaping ([Food], [FoodCategoryDTO]) -> Void) {
        let resource = Resource<Food>(url: URL(string: "any_url")!, modelType: Food.self)
        httpClient.load(resource) { result in
            switch result {
            case .success(let data):
                if let data: ProductCategories = data?.toModel() {
                    print(data)
                }
            case .failure(let error): print(error)
            }
        }
    }
    
    func goToDetailsScreen(food: Food) {
        //
    }
}
