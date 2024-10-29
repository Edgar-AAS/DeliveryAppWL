import Foundation

enum AccountStatus {
    case created(String)
}

final class CreateAccount: CreateAccountUseCase {
    private let httpClient: HTTPClientProtocol
    
    var registerAccountResource: ((CreateAccountModel) -> Resource)?
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func create(with request: CreateAccountModel, completion: @escaping (Result<CreateAccountStatusResponse, HttpError>) -> Void) {
        guard let httpResource = registerAccountResource?(request) else { return }
        
        httpClient.load(httpResource) { result in
            switch result {
            case .success(let data):
                if let model: CreateAccountStatusResponse = data?.toModel() {
                    completion(.success(.init(message: model.message)))
                } else {
                    completion(.failure(.unknown))
                }
            case .failure(let httpError):
                completion(.failure(httpError))
            }
        }
    }
}
