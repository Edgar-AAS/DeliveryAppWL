import Foundation

protocol LoginAccountUseCase {
    var loginResourceCallBack: ((LoginCredential) -> ResourceModel)? { get set }
    func login(with credential: LoginCredential, completion: @escaping (Result<AccountModelResponse, LoginError>) -> Void)
}
