import Foundation

protocol UpdateProfileDataViewModelProtocol {
    var loadingHandler: ((LoadingStateModel) -> ())? { get set }
    func updateProfileData(request: UpdateProfileDataRequest)
    func loadProfileData()
}
