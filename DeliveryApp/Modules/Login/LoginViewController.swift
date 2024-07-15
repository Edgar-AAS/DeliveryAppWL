import UIKit
import Firebase
import GoogleSignIn

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
        setupButtonsTarget()
        hideNavigationBar()
        hideKeyboardOnTap()
    }
    
    
    private func setupButtonsTarget() {
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

//MARK: - Google Login
extension LoginViewController {
    private func loginWithGoogleTap() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { [weak self] result, error in
            guard error == nil,
                  let user = result?.user,
                  let idToken = user.idToken?.tokenString else 
            { return }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { [weak self] result, error in
                if error == nil {
                    self?.viewModel.goToHome()
                }
            }
        }
    }
}

extension LoginViewController: LoginScreenDelegateProtocol {
    func loginWithGoogleButtonDidTapped() {
        loginWithGoogleTap()
    }
    
    func registerButtonDidTapped() {
        viewModel.goToSignUp()
    }
    
    func signInButtonDidTapped() {
        if let email = customView?.emailTextField.text,
           let password = customView?.passwordTextField.text {
            let loginRequest = LoginUserRequest(email: email, password: password)
            viewModel.signIn(loginRequest: loginRequest)
        }
    }
    
    func forgotPasswordButtonDidTapped() {
        viewModel.goToForgotPassword()
    }
}

extension LoginViewController: FieldDescription {
    func showMessage(viewModel: FieldDescriptionViewModel) {
        customView?.emailTextField.setDescriptionField(viewModel: viewModel)
        customView?.passwordTextField.setDescriptionField(viewModel: viewModel)
    }
}

extension LoginViewController: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        print(viewModel.message)
    }
}

