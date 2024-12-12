import Foundation

final class UpdateProfile: UpdateProfileDataUseCase {
    var httpResource: ((UpdateProfileRequestDTO) -> ResourceModel)?
    
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func update(with request: UpdateProfileRequestDTO, onComplete: @escaping (Result<UpdateProfileResponseDTO, UpdateProfileError>) -> Void) {
        guard let httpResourceModel = httpResource?(request) else {
            onComplete(.failure(.imageNotFound))
            return
        }
    
        httpClient.load(httpResourceModel) { result in
            switch result {
            case .success(let imageData):
                if let updateProfileResponse: UpdateProfileResponseDTO = imageData?.toModel() {
                    onComplete(.success(updateProfileResponse))
                } else {
                    onComplete(.failure(.decodedError))
                }
            case .failure(_):
                onComplete(.failure(.unexpectedError))
            }
        }
    }
}
