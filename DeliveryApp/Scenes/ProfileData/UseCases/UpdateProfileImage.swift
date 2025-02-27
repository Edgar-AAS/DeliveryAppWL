import Foundation

final class UpdateProfileImage: UpdateProfileImageUseCase {
    private let httpClient: HTTPClientProtocol
    
    var httpResource: ((ProfileImage) -> ResourceModel)?
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func update(imageRequest: ProfileImage, completion: @escaping (Result<ProfileImage, ProfileDataError>) -> Void) {
        guard let httpResourceModel = httpResource?(imageRequest) else {
            completion(.failure(.unexpected))
            return
        }
        
        httpClient.load(httpResourceModel) { result in
            switch result {
            case .success(let data):
                if let profileImage: ProfileImage = data?.toModel() {
                    completion(.success(profileImage))
                }
            case .failure(_):
                completion(.failure(.unexpected))
            }
        }
    }
}
