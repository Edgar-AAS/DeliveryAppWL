import Foundation

protocol LoginViewModelProtocol {
    func login(credential: LoginAccountCredentialDTO)
    var onLoginSuccess: (() -> Void)? { get set }
    var loadingHandler: ((LoadingStateModel) -> ())? { get set }
}
