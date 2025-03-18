import Foundation

protocol RegisterAccountUseCase {
    var registerAccountResource: ((RegisterAccountRequest) -> ResourceModel)? { get set }
    func register(with request: RegisterAccountRequest, completion: @escaping (Result<Void, RegisterError>) -> Void)
}

final class RegisterAccount: RegisterAccountUseCase {
    private let httpClient: HTTPClientProtocol
    
    var registerAccountResource: ((RegisterAccountRequest) -> ResourceModel)?
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func register(with request: RegisterAccountRequest, completion: @escaping (Result<Void, RegisterError>) -> Void) {
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
