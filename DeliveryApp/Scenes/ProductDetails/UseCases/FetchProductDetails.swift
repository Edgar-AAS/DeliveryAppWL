import Foundation

class FetchProductDetails: FetchProductDetailsUseCase {
    private let httpClient: HTTPClientProtocol
    private let resource: ResourceModel
    
    init(httpClient: HTTPClientProtocol, resource: ResourceModel) {
        self.httpClient = httpClient
        self.resource = resource
    }
    
    func fetch(completion: @escaping ((Result<Product, HTTPError>) -> Void)) {
        httpClient.load(resource) { result in
            switch result {
            case .success(let data):
                if let model: Product = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unknown))
                }
            case .failure(let httpError):
                completion(.failure(httpError))
            }
        }
    }
}
