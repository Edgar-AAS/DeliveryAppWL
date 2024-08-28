import UIKit

class RegistrationSuccessViewController: UIViewController {
//MARK: - Properties
    private lazy var customView: RegistrationSuccessScreen = {
        guard let view = view as? RegistrationSuccessScreen else {
            fatalError("View is not of type RegistrationSuccessScreen")
        }
        return view
    }()
    
    private let viewModel: RegistrationSuccessViewModelProtocol
    
//MARK: - Initializers
    init(viewModel: RegistrationSuccessViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = RegistrationSuccessScreen(delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView.setupUI(model: viewModel.getRegistrationSuccessModel())
    }
}

//MARK: - RegistrationSuccessScreenDelegate
extension RegistrationSuccessViewController: RegistrationSuccessScreenDelegate {
    func handleButtonDidTapped() {
        viewModel.goToLogin()
    }
}
