import Foundation

protocol RegisterViewModelProtocol {
    func createUser(userRequest: RegisterUserRequest)
    func toggleTerms(assined: Bool)
    var onRegisterSuccess: (() -> Void)? { get set }
    var loadingHandler: ((Bool) -> ())? { get set }
}
