import Foundation

protocol UpdateProfileDataViewModelProtocol: LoadingHandler {
    func updateProfileData(request: UserProfileRequest)
    func loadProfileData()
    func saveImage(profileImage: ProfileImage)
}

protocol UpdateProfileDataUseCase {
    var httpResource: ((UserProfileRequest) -> ResourceModel)? { get set }
    func update(with request: UserProfileRequest, completion: @escaping (Result<Void, ProfileDataError>) -> Void)
}

protocol FetchProfileDataUseCase {
    func fetch(completion: @escaping (Result<UserProfileResponse, ProfileDataError>) -> Void)
}

protocol UpdateProfileImageUseCase {
    func update(imageRequest: ProfileImage, completion: @escaping (Result<ProfileImage, ProfileDataError>) -> Void)
}
