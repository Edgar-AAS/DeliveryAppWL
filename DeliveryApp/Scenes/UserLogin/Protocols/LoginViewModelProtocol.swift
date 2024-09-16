import Foundation

protocol LoginViewModelProtocol {
    func goToSignUp()
    func goToForgotPassword()
    func signIn(loginRequest: LoginRequest)
    var loadingHandler: ((Bool) -> ())? { get set }
}
