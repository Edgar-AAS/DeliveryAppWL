import UIKit

class LoginViewController: UIViewController {
//MARK: - Properties
    private var viewModel: LoginViewModelProtocol
    
    var routeToRegisterCallBack: (() -> Void)?
    var routeToMainFlowCallBack: (() -> Void)?
    
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
       configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
        resetTextFields()
    }
    
    private func resetTextFields() {
        customView.resetTextFieldState()
    }
    
    private func configure() {
        viewModel.onLoginSuccess = { [weak self] in
            self?.routeToMainFlowCallBack?()
        }
        
        viewModel.loadingHandler = { [weak self] loadingState in
            self?.customView.handleLoadingView(with: loadingState)
        }
    }
}

extension LoginViewController: LoginScreenDelegate {
    func forgotPasswordButtonDidTapped(_ view: LoginScreen) {
        //
    }
    
    func signInButtonDidTapped(_ view: LoginScreen) {
        guard let loginRequest = customView.getUserLoginRequest() else { return }
        viewModel.login(credential: loginRequest)
    }
    
    func registerButtonDidTapped(_ view: LoginScreen) {
        routeToRegisterCallBack?()
    }
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        customView.goToNextField(
            textField,
            action: { [weak self] in
                if let loginRequest = self?.customView.getUserLoginRequest() {
                    self?.viewModel.login(credential: loginRequest)
                }
            }
        )
        return true
    }
}

//MARK: - FieldValidationDelegate
extension LoginViewController: FieldValidationDelegate {
    func clearError() {
        customView.clearFeedBackMessages()
    }
    
    func displayError(validationModel: ValidationFieldModel) {
        customView.showValidationError(validationModel: validationModel)
    }
}

//MARK: - AlertView
extension LoginViewController: AlertViewProtocol {
    func showMessage(viewModel: AlertViewModel) {
        showAlertView(title: viewModel.title, description: viewModel.message)
    }
}
