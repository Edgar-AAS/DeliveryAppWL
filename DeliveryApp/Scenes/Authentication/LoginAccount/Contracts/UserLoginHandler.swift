import Foundation

protocol UserLoginHandler {
    func login(credential: AuthRequest)
    var onSuccess: (() -> Void)? { get set }
    var loadingHandler: ((LoadingState) -> Void)? { get set }
}
