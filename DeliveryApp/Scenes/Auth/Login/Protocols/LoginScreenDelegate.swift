import Foundation

protocol LoginScreenDelegate: AnyObject {
    func forgotPasswordButtonDidTapped()
    func signInButtonDidTapped()
    func loginWithGoogleButtonDidTapped()
    func registerButtonDidTapped()
}
