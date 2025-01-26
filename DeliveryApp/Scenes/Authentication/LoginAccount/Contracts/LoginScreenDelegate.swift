import Foundation

protocol LoginScreenDelegate: AnyObject {
    func signInButtonDidTapped(_ view: LoginScreen)
    func registerButtonDidTapped(_ view: LoginScreen)
}
