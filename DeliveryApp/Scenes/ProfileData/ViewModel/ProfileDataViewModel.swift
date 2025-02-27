import Foundation

protocol UpdateProfileDataViewModelDelegate: AnyObject {
    func frofileDataViewModel(_ viewModel: ProfileDataViewModel, didUpdateUI  response: UserProfileResponse)
    func frofileDataViewModel(_ viewModel: ProfileDataViewModel, didUpdateProfileImage image: ProfileImage)
}

final class ProfileDataViewModel: UpdateProfileDataViewModelProtocol {
    var loadingHandler: ((Bool) -> ())?
    weak var alertView: AlertViewProtocol?
    weak var delegate: UpdateProfileDataViewModelDelegate?
    
    private let updateProfile: UpdateProfileDataUseCase
    private let fetchProfileData: FetchProfileDataUseCase
    private let updateProfileImage: UpdateProfileImageUseCase
    
    init(updateProfile: UpdateProfileDataUseCase,
         fetchProfileData: FetchProfileDataUseCase,
         updateProfileImage: UpdateProfileImageUseCase
    ) {
        self.updateProfile = updateProfile
        self.fetchProfileData = fetchProfileData
        self.updateProfileImage = updateProfileImage
    }
    
    func loadProfileData() {
        fetchProfileData.fetch { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let profileResponse):
                self.delegate?.frofileDataViewModel(self, didUpdateUI: profileResponse)
            case .failure(_):
                return
            }
        }
    }
    
    func updateProfileData(request: UserProfileRequest) {
        loadingHandler?(true)
        
        updateProfile.update(with: request) { [weak self] result in
            switch result {
            case .success:
                self?.loadingHandler?(false)
            case .failure(_):
                self?.loadingHandler?(false)
            }
        }
    }
    
    func saveImage(profileImage: ProfileImage) {
        loadingHandler?(true)
        
        updateProfileImage.update(imageRequest: profileImage) { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let profileImage):
                self.delegate?.frofileDataViewModel(self, didUpdateProfileImage: profileImage)
                self.loadingHandler?(false)
            case .failure(_):
                self.loadingHandler?(false)
            }
        }
    }
}
