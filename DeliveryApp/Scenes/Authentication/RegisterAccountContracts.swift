import Foundation

protocol RegisterViewModelProtocol: LoadingHandler {
    func createAccount(userRequest: RegisterAccountModel)
    func toggleTerms(assined: Bool)
    var createdAccountCallBack: (() -> Void)? { get set }
}

protocol RegisterAccountUseCase {
    var registerAccountResource: ((RegisterAccountRequest) -> ResourceModel)? { get set }
    func register(with request: RegisterAccountRequest, completion: @escaping (Result<Void, RegisterError>) -> Void)
}

protocol RegisterScreenDelegate: AnyObject {
    func goToLoginButtonDidTapped(_ view: RegisterScreen)
    func registerButtonDidTapped(_ view: RegisterScreen)
}
