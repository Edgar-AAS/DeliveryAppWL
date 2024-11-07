import Foundation

class FetchProductDetails: FetchProductDetailsUseCase {
    private let httpClient: HTTPClientProtocol
    private let resource: Resource
    
    init(httpClient: HTTPClientProtocol, resource: Resource) {
        self.httpClient = httpClient
        self.resource = resource
    }
    
    func fetch(completion: @escaping ((Result<ProductDetailsResponse, HttpError>) -> Void)) {
        httpClient.load(resource) { result in
            switch result {
            case .success(let data):
                if let model: ProductDetailsResponse = data?.toModel() {
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