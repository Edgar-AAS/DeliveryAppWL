import Foundation

protocol RegisterViewModelProtocol {
    func createAccount(userRequest: RegisterUserRequest)
    func toggleTerms(assined: Bool)
    var createdAccountCallBack: (() -> Void)? { get set }
    var loadingHandler: ((LoadingState) -> ())? { get set }
}
