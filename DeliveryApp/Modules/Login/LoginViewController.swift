import UIKit

class LoginViewController: UIViewController {
    private let viewModel: LoginViewModelProtocol
    
    private lazy var customView: LoginScreen? = {
        return view as? LoginScreen
    }()
    
    override func loadView() {
        super.loadView()
        view = LoginScreen()
    }
    
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTargets()
        hideNavigationBar()
        hideKeyboardOnTap()
    }
    
    private func setupTargets() {
        customView?.emailTextField.delegate = self
        customView?.passwordTextField.delegate = self
        customView?.delegate = self
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0  {
            customView?.passwordTextField.becomeFirstResponder()
        } else if textField.tag == 1 {
            signInButtonDidTapped()
            customView?.passwordTextField.resignFirstResponder()
        }
        return true
    }
}

//MARK: - Delegate Actions
extension LoginViewController: LoginScreenDelegateProtocol {
    func loginWithGoogleButtonDidTapped() {
        GoogleLogin.showGoogleLogin(target: self) { [weak self] in
            self?.viewModel.goToHome()
        }
    }
    
    func registerButtonDidTapped() {
        viewModel.goToSignUp()
    }
    
    func signInButtonDidTapped() {
        if let email = customView?.emailTextField.text,
           let password = customView?.passwordTextField.text {
            let authenticationModel = AuthenticationModel(email: email, password: password)
            viewModel.signIn(authenticationModel: authenticationModel)
        }
    }
    
    func forgotPasswordButtonDidTapped() {
        viewModel.goToForgotPassword()
    }
}

extension LoginViewController: FieldDescriptionProtocol {
    func showMessage(viewModel: FieldDescriptionViewModel) {
        customView?.emailTextField.setDescriptionField(viewModel: viewModel)
        customView?.passwordTextField.setDescriptionField(viewModel: viewModel)
    }
}

extension LoginViewController: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        //MARK: - Handling Errors
    }
}
