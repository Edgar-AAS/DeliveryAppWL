import Foundation

protocol UpdateProfileDataViewModelProtocol {
    var loadingHandler: ((LoadingState) -> ())? { get set }
    func updateProfileData(request: UserRequest)
    func loadProfileData()
}
