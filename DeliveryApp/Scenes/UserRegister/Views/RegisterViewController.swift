import UIKit

class RegisterViewController: UIViewController {
//MARK: - Properties
    private lazy var customView: RegisterScreen = {
        guard let view = view as? RegisterScreen else {
            fatalError("View is not of type RegisterScreen")
        }
        return view
    }()
    
    private var viewModel: RegisterViewModelProtocol
    
//MARK: - Initializers
    init(viewModel: RegisterViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = RegisterScreen(delegate: self,
                              textFieldDelegate: self,
                              checkBoxDelegate: self
        )
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

//MARK: - SignUpScreenDelegateProtocol
extension RegisterViewController: SignUpScreenDelegate {
    func goToLoginButtonDidTapped() {
        viewModel.routeToLogin()
    }
    
    func loginWithGoogleButtonDidTapped() {
        GoogleLogin.showGoogleLogin(target: self) { [weak self] in
            self?.viewModel.routeToHome()
        }
    }
    
    func registerButtonDidTapped() {
        guard let registerRequest = customView.getRegisterUserRequest() else { return }
        viewModel.createUser(userRequest: registerRequest)
    }
}

//MARK: - UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        customView.goToNextField(
            textField,
            action: { [weak self] in
                guard let registerRequest = self?.customView.getRegisterUserRequest() else { return }
                self?.viewModel.createUser(userRequest: registerRequest)
            }
        )
        return true
    }
}

//MARK: - FieldValidationDelegate
extension RegisterViewController: FieldValidationDelegate {
    func showMessage(viewModel: FieldValidationViewModel) {
        customView.setupValidationErrors(viewModel: viewModel)
    }
}

//MARK: - CheckBoxDelegate
extension RegisterViewController: CheckBoxDelegate {
    func checkBoxDidChange(_ checkBox: CheckBoxButton, isChecked: Bool) {
        viewModel.toggleTerms(assined: isChecked)
    }
}

//MARK: - AlertView
extension RegisterViewController: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        let alert = makeAlertVIew(title: viewModel.title, message: viewModel.message)
        present(alert, animated: true)
    }
}

