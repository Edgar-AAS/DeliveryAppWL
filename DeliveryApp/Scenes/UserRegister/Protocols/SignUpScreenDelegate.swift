import Foundation

protocol SignUpScreenDelegate: AnyObject {
    func goToLoginButtonDidTapped()
    func loginWithGoogleButtonDidTapped()
    func registerButtonDidTapped()
}
