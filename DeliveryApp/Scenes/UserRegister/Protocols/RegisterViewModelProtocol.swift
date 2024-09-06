import Foundation

protocol RegisterViewModelProtocol {
    func createUser(userRequest: RegisterUserRequest)
    func routeToHome()
    func routeToLogin()
    func toggleTerms(assined: Bool)
    var loadingHandler: ((Bool) -> ())? { get set }
}
