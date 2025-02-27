import UIKit

final class RegisterSucceedViewController: UIViewController {
//MARK: - Properties
    private lazy var customView: RegisterSucceedScreen = {
        guard let view = view as? RegisterSucceedScreen else {
            fatalError("View is not of type RegistrationSuccessScreen")
        }
        return view
    }()
    
    var routeToLogin: (() -> Void)?
        
//MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = RegisterSucceedScreen(delegate: self)
    }
}

//MARK: - RegistrationSuccessScreenDelegate
extension RegisterSucceedViewController: RegisterSucceedScreenDelegate {
    func verifyAccountButtonDidTapped(_ view: RegisterSucceedScreen) {
        routeToLogin?()
    }
}
