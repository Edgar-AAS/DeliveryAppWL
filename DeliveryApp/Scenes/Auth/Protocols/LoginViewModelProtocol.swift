import Foundation

protocol LoginViewModelProtocol {
    func signIn(loginRequest: LoginRequest)
    var onLoginSuccess: (() -> Void)? { get set }
    var loadingHandler: ((Bool) -> ())? { get set }
}
