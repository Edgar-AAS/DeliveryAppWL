import Foundation

protocol FetchFoodCategoriesUseCase {
    func fetch(completion: @escaping (Result<[CategoryDTO], RequestError>) -> Void)
}

final class FetchFoodCategories: FetchFoodCategoriesUseCase {
    private let httpClient: HTTPClientProtocol
    private let httpResource: ResourceModel
    
    init(httpClient: HTTPClientProtocol, resource: ResourceModel) {
        self.httpClient = httpClient
        self.httpResource = resource
    }
        
    func fetch(completion: @escaping (Result<[CategoryDTO], RequestError>) -> Void) {
        httpClient.load(httpResource) { result in
            switch result {
            case .success(let data):
                if let categories: [CategoryDTO] = data?.toModel() {
                    completion(.success(categories))
                } else {
                    completion(.failure(.unknown))
                }
            case .failure(let httpError):
                completion(.failure(httpError))
            }
        }
    }
}
