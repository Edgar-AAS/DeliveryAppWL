import Foundation

protocol LoginViewModelProtocol {
    func signIn(credential: LoginCredential)
    var onLoginSuccess: (() -> Void)? { get set }
    var loadingHandler: ((LoadingState) -> ())? { get set }
}
