import UIKit

final class LoginViewController: UIViewController {
//MARK: - Properties
    private var viewModel: UserLoginHandler
    
    var routeToRegister: (() -> Void)?
    var routeToMainFlow: (() -> Void)?
    
    private lazy var customView: LoginScreen = {
        guard let view = view as? LoginScreen else {
            fatalError("View is not of type LoginScreen")
        }
        return view
    }()
    
//MARK: - Initializers
    init(viewModel: UserLoginHandler) {
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
        customView.resetTextFieldState()
    }
    
    private func configure() {
        viewModel.onSuccess = { [weak self] in
            self?.routeToMainFlow?()
        }
        
        viewModel.loadingHandler = { [weak self] state in
            self?.customView.handleLoadingView(with: state)
        }
    }
}

//MARK: - LoginScreenDelegate
extension LoginViewController: LoginScreenDelegate {
    func signInButtonDidTapped(_ view: LoginScreen) {
        guard let loginRequest = customView.getUserLoginRequest() else { return }
        viewModel.login(credential: loginRequest)
    }
    
    func registerButtonDidTapped(_ view: LoginScreen) {
        routeToRegister?()
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
extension LoginViewController: FeedBackTextFieldProtocol {
    func clearError() {
        customView.resetTextFieldState()
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
