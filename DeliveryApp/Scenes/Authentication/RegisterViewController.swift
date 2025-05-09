import UIKit

final class RegisterViewController: UIViewController {
//MARK: - Properties
    private lazy var customView: RegisterScreen = {
        guard let view = view as? RegisterScreen else {
            fatalError("View is not of type RegisterScreen")
        }
        return view
    }()
    
    var routeToLoginCallBack: (() -> Void)?
    var routeToSuccessScreenCallBack: (() -> Void)?
    
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
        
        view = RegisterScreen(
            delegate: self,
            textFieldDelegate: self,
            checkBoxDelegate: self
        )
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.createdAccountCallBack = { [weak self] in
            self?.routeToSuccessScreenCallBack?()
        }
        
        viewModel.loadingHandler = { [weak self] state in
            self?.customView.handleLoadingView(with: state)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    private func registerAccount() {
        if let registerRequest = customView.getRequest() {
            viewModel.createAccount(userRequest: registerRequest)
        }
    }
}

//MARK: - SignUpScreenDelegateProtocol
extension RegisterViewController: RegisterScreenDelegate {
    func goToLoginButtonDidTapped(_ view: RegisterScreen) {
        routeToLoginCallBack?()
    }
    
    func registerButtonDidTapped(_ view: RegisterScreen) {
        registerAccount()
    }
}

//MARK: - UITextFieldDelegate
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        customView.goToNextField(textField) { [weak self] in
            self?.registerAccount()
        }
        return true
    }
}

//MARK: - CheckBoxDelegate
extension RegisterViewController: CheckBoxDelegate {
    func checkBoxDidChange(_ checkBox: DACheckBoxButton, isChecked: Bool) {
        viewModel.toggleTerms(assined: isChecked)
    }
}
    
//MARK: - AlertView
extension RegisterViewController: AlertViewProtocol {
    func showMessage(viewModel: AlertViewModel) {
        showAlertView(title: viewModel.title, description: viewModel.message)
    }
}
