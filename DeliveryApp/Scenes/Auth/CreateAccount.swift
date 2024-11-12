import Foundation

final class CreateAccount: CreateAccountUseCase {
    private let httpClient: HTTPClientProtocol
    
    var registerAccountResource: ((CreateAccountModel) -> ResourceModel)?
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func create(with request: CreateAccountModel, completion: @escaping (Result<CreateAccountResponse, HttpError>) -> Void) {
        guard let httpResource = registerAccountResource?(request) else { return }
        
        httpClient.load(httpResource) { result in
            switch result {
            case .success(let data):
                if let model: CreateAccountResponse = data?.toModel() {
                    completion(.success(model))
                }
            case .failure(let httpError):
                completion(.failure(httpError))
            }
        }
    }
}
