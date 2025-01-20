import Foundation

protocol LoginAccountUseCase {
    var loginResourceCallBack: ((AuthResquest) -> ResourceModel)? { get set }
    func login(with credential: AuthResquest, completion: @escaping (Result<AuthResponse, LoginError>) -> Void)
}
