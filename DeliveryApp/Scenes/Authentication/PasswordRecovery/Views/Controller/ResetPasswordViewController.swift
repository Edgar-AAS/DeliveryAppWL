import UIKit

class ResetPasswordViewController: UIViewController {
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

extension ResetPasswordViewController: FieldValidationDelegate {
    func displayError(validationModel: ValidationFieldModel) {
        
    }
    
    func clearError() {
        
    }
}
