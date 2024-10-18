import Foundation

class FetchProductDetails: FetchProductDetailsUseCase {
    private let httpClient: HTTPClientProtocol
    private let resource: Resource<ProductDetailsResponse>
    
    init(httpClient: HTTPClientProtocol, resource: Resource<ProductDetailsResponse>) {
        self.httpClient = httpClient
        self.resource = resource
    }
    
    func fetch(completion: @escaping ((Result<ProductDetailsResponse, HttpError>) -> Void)) {
        httpClient.load(resource) { result in
            switch result {
            case .success(let response):
                if let productDetailsReponse = response {
                    completion(.success(productDetailsReponse))
                }
            case .failure(let httpError):
                completion(.failure(httpError))
            }
        }
    }
}
