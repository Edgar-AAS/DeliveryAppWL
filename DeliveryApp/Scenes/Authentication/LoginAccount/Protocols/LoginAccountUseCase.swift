import Foundation

protocol LoginAccountUseCase {
    var loginResourceCallBack: ((LoginAccountCredentialDTO) -> ResourceModel)? { get set }
    func login(with credential: LoginAccountCredentialDTO, completion: @escaping (Result<LoginAccountResponseDTO, LoginError>) -> Void)
}
