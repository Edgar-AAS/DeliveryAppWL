import Foundation

final class FetchProfileData: FetchProfileDataUseCase {
    private let httpResource: ResourceModel
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol, httpResource: ResourceModel) {
        self.httpClient = httpClient
        self.httpResource = httpResource
    }
    
    func fetch(completion: @escaping (Result<UserProfileResponse, ProfileDataError>) -> Void) {
        httpClient.load(httpResource) { [weak self] result in
            guard self != nil else {
                return
            }
            
            switch result {
            case .success(let data):
                if let profileResponse: UserProfileResponse = data?.toModel() {
                    completion(.success(profileResponse))
                }
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

