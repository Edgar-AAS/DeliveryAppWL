import UIKit

class ForgotPasswordViewController: UIViewController {
    //MARK: - Properties
    private lazy var customView: ForgotPasswordScreen = {
        guard let view = view as? ForgotPasswordScreen else {
            fatalError("View is not of type ForgotPasswordScreen")
        }
        return view
    }()
    
    private let viewModel: ForgotPasswordViewModelProtocol
    
    //MARK: - Initializers
    init(viewModel: ForgotPasswordViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = ForgotPasswordScreen(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.loadingHandler = { [weak self] isLoading in
            self?.setUserInteractionEnabled(isLoading)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar()
    }
    
    //MARK: - setUserInteractionEnabled
    private func setUserInteractionEnabled(_ isEnable: Bool) {
        navigationController?.navigationBar.isUserInteractionEnabled = !isEnable
        customView.handleLoadingAnimation(isEnable)
    }
}

//MARK: - FieldValidationDelegate
extension ForgotPasswordViewController: FieldValidationDelegate {
    func showMessage(viewModel: FieldValidationViewModel) {
        customView.setupValidationErrors(viewModel: viewModel)
    }
}

//MARK: - ForgotPasswordScreenDelegate
extension ForgotPasswordViewController: ForgotPasswordScreenDelegate {
    func continueButtonDidTapped() {
        guard let forgotPasswordUserRequest = customView.getForgotPasswordUserRequest() else { return }
        viewModel.sendPasswordReset(with: forgotPasswordUserRequest)
    }
}
