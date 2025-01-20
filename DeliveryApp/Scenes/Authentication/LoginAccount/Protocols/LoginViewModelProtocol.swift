import Foundation

protocol LoginViewModelProtocol {
    func login(credential: AuthResquest)
    var onLoginSuccess: (() -> Void)? { get set }
    var loadingHandler: ((LoadingStateModel) -> ())? { get set }
}
