import UIKit

final class RegisterSucceedViewController: UIViewController {
//MARK: - Properties
    private lazy var customView: RegisterSucceedScreen = {
        guard let view = view as? RegisterSucceedScreen else {
            fatalError("View is not of type RegistrationSuccessScreen")
        }
        return view
    }()
    
    var routeToLoginCallback: (() -> Void)?
    
    private let viewModel: RegisterSucceedViewModelProtocol
    
//MARK: - Initializers
    init(viewModel: RegisterSucceedViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = RegisterSucceedScreen(delegate: self)
    }
}

//MARK: - RegistrationSuccessScreenDelegate
extension RegisterSucceedViewController: RegisterSucceedScreenDelegate {
    func verifyAccountButtonDidTapped(_ view: RegisterSucceedScreen) {
        routeToLoginCallback?()
    }
}
