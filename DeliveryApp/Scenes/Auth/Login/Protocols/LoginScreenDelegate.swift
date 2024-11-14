import Foundation

protocol LoginScreenDelegate: AnyObject {
    func forgotPasswordButtonDidTapped(_ view: LoginScreen)
    func signInButtonDidTapped(_ view: LoginScreen)
    func registerButtonDidTapped(_ view: LoginScreen)
}
