import Foundation

class FetchProductCategories: FetchProductCategoriesUseCase {
    private let httpClient: HTTPClientProtocol
    private let resource: ResourceModel
    
    init(httpClient: HTTPClientProtocol, resource: ResourceModel) {
        self.httpClient = httpClient
        self.resource = resource
    }
        
    func fetch(completion: @escaping (Result<[ProductCategoryResponse], HTTPError>) -> Void) {
        httpClient.load(resource) { result in
            switch result {
            case .success(let data):
                if let model: [ProductCategoryResponse] = data?.toModel() {
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
