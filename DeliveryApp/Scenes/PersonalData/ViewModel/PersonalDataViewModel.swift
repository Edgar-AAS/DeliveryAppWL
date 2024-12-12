import Foundation

final class PersonalDataViewModel: PersonalDataViewModelProtocol {
    weak var alertView: AlertViewProtocol?
    weak var delegate: PersonalDataViewModelDelegate?
    
    private let updateProfile: UpdateProfileDataUseCase
    
    init(updateProfile: UpdateProfileDataUseCase) {
        self.updateProfile = updateProfile
    }
    
    func updateProfileImage(request: UpdateProfileRequestDTO) {
        updateProfile.update(with: request) { result in
            switch result {
            case .success(let profileResponse):
                break
            case .failure(let profileError):
                switch profileError {
                case .unexpectedError:
                    let alertViewModel = AlertViewModel(
                        title: "Error",
                        message: "Erro inesperado ao salvar imagem, tente novamente em instantes."
                    )
                    self.alertView?.showMessage(viewModel: alertViewModel)
                default: break
                }
            }
        }
    }
}
