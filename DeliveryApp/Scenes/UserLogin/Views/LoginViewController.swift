import UIKit

class LoginViewController: UIViewController {
//MARK: - Properties
    private var viewModel: LoginViewModelProtocol
    
    private lazy var customView: LoginScreen = {
        guard let view = view as? LoginScreen else {
            fatalError("View is not of type LoginScreen")
        }
        return view
    }()

//MARK: - Initializers
    init(viewModel: LoginViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = LoginScreen(delegate: self, textFieldDelegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadingHandler = { [weak self] isLoading in
            self?.customView.handleLoadingAnimation(isLoading)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
}

//MARK: - LoginScreenDelegateProtocol
extension LoginViewController: LoginScreenDelegate {
    func loginWithGoogleButtonDidTapped() {
        //
    }
    
    func registerButtonDidTapped() {
        viewModel.goToSignUp()
    }
    
    func signInButtonDidTapped() {
        guard let loginRequest = customView.getUserLoginRequest() else { return }
        viewModel.signIn(loginRequest: loginRequest)
    }
    
    func forgotPasswordButtonDidTapped() {
        viewModel.goToForgotPassword()
    }
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        customView.goToNextField(
            textField,
            action: { [weak self] in
                guard let loginRequest = self?.customView.getUserLoginRequest() else { return }
                self?.viewModel.signIn(loginRequest: loginRequest)
            }
        )
        return true
    }
}

//MARK: - FieldValidationDelegate
extension LoginViewController: FieldValidationDelegate {
    func showMessage(viewModel: FieldValidationViewModel) {
        customView.setupValidationErrors(viewModel: viewModel)
    }
}

//MARK: - AlertView
extension LoginViewController: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        let alert = makeAlertVIew(title: viewModel.title, message: viewModel.message)
        present(alert, animated: true)
    }
}
