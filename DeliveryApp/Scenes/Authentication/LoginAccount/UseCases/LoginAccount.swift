
import Foundation

final class LoginAccount: LoginAccountUseCase {
    private let httpClient: HTTPClientProtocol
    var loginResourceCallBack: ((AuthResquest) -> ResourceModel)?
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func login(with credential: AuthResquest, completion: @escaping  (Result<AuthResponse, LoginError>) -> Void) {
        guard let httpResource = loginResourceCallBack?(credential) else { return }
        
        httpClient.load(httpResource) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
            case .failure(let httpError):
                switch httpError {
                case .unauthorized:
                    completion(.failure(.invalidCredentials))
                case .noConnectivity:
                    completion(.failure(.noConnectivity))
                default:
                    completion(.failure(.unexpected))
                }
            case .success(let data):
                if let model: AuthResponse = data?.toModel() {
                    completion(.success(model))
                }
            }
        }
    }
}
