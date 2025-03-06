import Foundation

protocol LoginAccountUseCase {
    var httpResource: ((LoginAccountRequest) -> ResourceModel)? { get set }
    func login(with credential: LoginAccountRequest, completion: @escaping (Result<LoginAccountResponse, LoginAccountError>) -> Void)
}

final class LoginAccount: LoginAccountUseCase {
    private let httpClient: HTTPClientProtocol
    private let keychainService: KeychainService
    
    var httpResource: ((LoginAccountRequest) -> ResourceModel)?
    
    init(httpClient: HTTPClientProtocol, keychainService: KeychainService) {
        self.httpClient = httpClient
        self.keychainService = keychainService
    }
    
    func login(with credential: LoginAccountRequest, completion: @escaping (Result<LoginAccountResponse, LoginAccountError>) -> Void) {
        guard let httpResource = httpResource?(credential) else {
            completion(.failure(.unexpected))
            return
        }
        
        httpClient.load(httpResource) { [weak self] result in
            guard let self = self else { return }
            
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
                guard let response: LoginAccountResponse = data?.toModel() else {
                    completion(.failure(.unexpected))
                    return
                }
                
                DispatchQueue.global().async {
                    self.storeToken(token: response.accessToken)
                    
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
        keychainService.save(
            key: Strings.Keychain.Keys.accessToken,
            value: token
        )
    }
}
