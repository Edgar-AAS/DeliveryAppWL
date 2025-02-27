import Foundation

protocol LoginAccountUseCase {
    var httpResource: ((AuthRequest) -> ResourceModel)? { get set }
    func login(with credential: AuthRequest, completion: @escaping (Result<AuthResponse, LoginError>) -> Void)
}

protocol LoginScreenDelegate: AnyObject {
    func signInButtonDidTapped(_ view: LoginScreen)
    func registerButtonDidTapped(_ view: LoginScreen)
}

protocol UserLoginHandler: LoadingHandler {
    func login(credential: AuthRequest)
    var onSuccess: (() -> Void)? { get set }
}

protocol LoadingHandler {
    var loadingHandler: ((Bool) -> Void)? { get set }
}
