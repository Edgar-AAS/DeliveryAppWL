import Foundation

protocol FetchFoodCategoriesUseCase {
    func fetch(completion: @escaping (Result<[ProductCategory], RequestError>) -> Void)
}

final class FetchFoodCategories: FetchFoodCategoriesUseCase {
    private let httpClient: HTTPClientProtocol
    private let httpResource: ResourceModel
    
    init(httpClient: HTTPClientProtocol, resource: ResourceModel) {
        self.httpClient = httpClient
        self.httpResource = resource
    }
        
    func fetch(completion: @escaping (Result<[ProductCategory], RequestError>) -> Void) {
        httpClient.load(httpResource) { result in
            switch result {
            case .success(let data):
                if let model: [ProductCategory] = data?.toModel() {
                    let activeCategories = model.filter { $0.isActive }
                    completion(.success(activeCategories))
                } else {
                    completion(.failure(.unknown))
                }
            case .failure(let httpError):
                completion(.failure(httpError))
            }
        }
    }
}
