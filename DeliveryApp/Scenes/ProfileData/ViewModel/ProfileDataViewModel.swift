import Foundation

protocol UpdateProfileDataViewModelDelegate: AnyObject {
    func updateUI(with response: UserRequest)
}

final class ProfileDataViewModel: UpdateProfileDataViewModelProtocol {
    var loadingHandler: ((LoadingState) -> ())?
    weak var alertView: AlertViewProtocol?
    weak var delegate: UpdateProfileDataViewModelDelegate?
    
    private let updateProfile: UpdateProfileDataUseCase
    private let fetchProfileData: FetchProfileDataUseCase
    
    init(updateProfile: UpdateProfileDataUseCase, fetchProfileData: FetchProfileDataUseCase) {
        self.updateProfile = updateProfile
        self.fetchProfileData = fetchProfileData
    }
    
    func loadProfileData() {
        fetchProfileData.fetch { [weak self] result in
            switch result {
            case .success(let profileResponse):
                self?.delegate?.updateUI(with: profileResponse)
            case .failure(_):
                return
            }
        }
    }
    
    func updateProfileData(request: UserRequest) {
        loadingHandler?(.init(isLoading: true))
        
        updateProfile.update(with: request) { [weak self] result in
            switch result {
            case .success:
                self?.loadingHandler?(.init(isLoading: false))
            case .failure(let updateError):
                switch updateError {
                case .unexpectedError:
                    self?.loadingHandler?(.init(isLoading: false))
                }
            }
        }
    }
}
