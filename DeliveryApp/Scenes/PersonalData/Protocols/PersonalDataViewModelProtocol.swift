import Foundation

protocol PersonalDataViewModelProtocol {
    var delegate: PersonalDataViewModelDelegate? { get set }
    func updateProfileImage(request: UpdateProfileRequestDTO)
}
