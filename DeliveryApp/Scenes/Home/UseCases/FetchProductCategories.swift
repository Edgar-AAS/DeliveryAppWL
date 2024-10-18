import Foundation

class FetchProductCategories: FetchProductCategoriesUseCase {
    private let httpClient: HTTPClientProtocol
    private let resource: Resource<[ProductCategoryResponse]>
    
    init(httpClient: HTTPClientProtocol, resource: Resource<[ProductCategoryResponse]>) {
        self.httpClient = httpClient
        self.resource = resource
    }
    
    func fetch(completion: @escaping (Result<[ProductCategoryResponse], HttpError>) -> Void) {
        httpClient.load(resource) { result in
            switch result {
            case .success(let response):
                if let productCategories = response {
                    let activeCategories = productCategories.filter { $0.isActive }
                    completion(.success(activeCategories))
                }
            case .failure(let httpError):
                completion(.failure(httpError))
            }
        }
    }
}
