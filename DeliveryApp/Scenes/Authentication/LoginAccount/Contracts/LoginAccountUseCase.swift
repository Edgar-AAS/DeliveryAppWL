import Foundation

protocol LoginAccountUseCase {
    var httpResource: ((AuthRequest) -> ResourceModel)? { get set }
    func login(with credential: AuthRequest, completion: @escaping (Result<AuthResponse, LoginError>) -> Void)
}
