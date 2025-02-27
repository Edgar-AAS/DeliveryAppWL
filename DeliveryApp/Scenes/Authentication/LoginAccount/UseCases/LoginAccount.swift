import Foundation

final class LoginAccount: LoginAccountUseCase {
    private let httpClient: HTTPClientProtocol
    var httpResource: ((AuthRequest) -> ResourceModel)?
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func login(with credential: AuthRequest, completion: @escaping  (Result<AuthResponse, LoginError>) -> Void) {
        guard let httpResource = httpResource?(credential) else {
            completion(.failure(.unexpected))
            return
        }
        
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
                guard let response: AuthResponse = data?.toModel() else {
                    completion(.failure(.unexpected))
                    return
                }
                
                DispatchQueue.global().async {                    
                    self?.storeToken(token: response.accessToken)
                    
                    DispatchQueue.main.async {
                        switch result {
                        case .success:
                            completion(.success(response))
                        case .failure(_):
                            completion(.failure(.unexpected))
                        }
                    }
                }
            }
        }
    }
    
    private func storeToken(token: String) {
        KeychainManager.save(key: KeychainConstants.Keys.accessToken, value: token)
    }
}
