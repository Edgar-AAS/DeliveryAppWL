import Foundation

class LoginBuilder {
    static func build() -> LoginViewController {
        let httpClient: HTTPClientProtocol = HTTPClient()
        let userAccountLogin = UserAccountLogin(httpClient: httpClient)
        
        userAccountLogin.loginResourceCallBack = { credential in
            return Resource(url: URL(string: "http://localhost:5177/v1/accounts/login")!,
                                    method: .post(credential.toData()),
                                    headers: ["Content-Type": "application/json"])
        }
        
        let emailValidator: EmailValidaton = EmailValidator()
        
        let viewModel = LoginViewModel(
            userAccountLogin: userAccountLogin,
            emailValidation: emailValidator)
        
        let viewController = LoginViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
