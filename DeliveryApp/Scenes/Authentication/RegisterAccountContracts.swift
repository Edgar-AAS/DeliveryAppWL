import Foundation

protocol RegisterViewModelProtocol: LoadingHandler {
    func createAccount(userRequest: RegisterAccountModel)
    func toggleTerms(assined: Bool)
    var createdAccountCallBack: (() -> Void)? { get set }
}

protocol RegisterScreenDelegate: AnyObject {
    func goToLoginButtonDidTapped(_ view: RegisterScreen)
    func registerButtonDidTapped(_ view: RegisterScreen)
}
