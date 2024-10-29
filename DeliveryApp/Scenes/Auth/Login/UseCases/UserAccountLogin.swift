
import Foundation

protocol AccountLoginUseCase {
    func login(with credential: LoginCredential, completion: @escaping (Result<AccountModelResponse, HttpError>) -> Void)
}

class UserAccountLogin: AccountLoginUseCase {
    private let httpClient: HTTPClientProtocol
    var loginResourceCallBack: ((LoginCredential) -> Resource)?
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func login(with credential: LoginCredential, completion: @escaping  (Result<AccountModelResponse, HttpError>) -> Void) {
        guard let httpResource = loginResourceCallBack?(credential) else { return }
        
        httpClient.load(httpResource) { [weak self] result in
            guard self != nil else { return }
            
            switch result {
                case .failure(let httpError):
                    completion(.failure(httpError))
            case .success(let data):
                if let model: AccountModelResponse = data?.toModel() {
                    completion(.success(model))
                } else {
                    completion(.failure(.unknown))
                }
            }
        }
    }
}
