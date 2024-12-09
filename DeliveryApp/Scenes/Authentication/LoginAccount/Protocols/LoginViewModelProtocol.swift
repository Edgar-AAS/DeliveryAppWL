import Foundation

protocol LoginViewModelProtocol {
    func login(credential: LoginCredential)
    var onLoginSuccess: (() -> Void)? { get set }
    var loadingHandler: ((LoadingStateModel) -> ())? { get set }
}
