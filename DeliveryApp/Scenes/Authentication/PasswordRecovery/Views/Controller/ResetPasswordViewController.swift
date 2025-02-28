import UIKit

final class ResetPasswordViewController: UIViewController {
    private lazy var customView: ResetPasswordScreen? = {
        return view as? ResetPasswordScreen
    }()
    
    override func loadView() {
        super.loadView()
        view = ResetPasswordScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
