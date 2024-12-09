import Foundation

final class CreateAccount: CreateAccountUseCase {
    private let httpClient: HTTPClientProtocol
    
    var registerAccountResource: ((CreateAccountModel) -> ResourceModel)?
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func create(with request: CreateAccountModel, completion: @escaping (Result<Void, RegisterError>) -> Void) {
        guard let httpResource = registerAccountResource?(request) else { return }
        
        httpClient.load(httpResource) { result in
            switch result {
            case .success(_):
                completion(.success(()))
            case .failure(let httpError):
                switch httpError {
                case .conflict:
                    completion(.failure(.emailInUse))
                case .noConnectivity:
                    completion(.failure(.noConnectivity))
                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
}


