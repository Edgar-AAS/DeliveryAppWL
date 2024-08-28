import Foundation

protocol LoginViewModelProtocol {
    func goToSignUp()
    func goToHome()
    func goToForgotPassword()
    func signIn(loginRequest: LoginRequest)
    var loadingHandler: ((Bool) -> ())? { get set }
}
