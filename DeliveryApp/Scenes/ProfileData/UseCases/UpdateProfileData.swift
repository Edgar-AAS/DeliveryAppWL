import Foundation

final class UpdateProfileData: UpdateProfileDataUseCase {
    var httpResource: ((UserProfileRequest) -> ResourceModel)?
    
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func update(with request: UserProfileRequest, completion: @escaping (Result<Void, ProfileDataError>) -> Void) {
        guard let httpResourceModel = httpResource?(request) else {
            completion(.failure(.unexpected))
            return
        }
        
        httpClient.load(httpResourceModel) { [weak self] result in
            guard self != nil else {
                return
            }
            
            switch result {
            case .success(_):
                completion(.success(()))
            case .failure(let httpError):
                switch httpError {
                case .unauthorized:
                    completion(.failure(.unauthorized))
                default:
                    completion(.failure(.unexpected))
                }
            }
        }
    }
}


