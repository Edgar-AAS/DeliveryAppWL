import UIKit

class PersonalDataViewController: UIViewController {
    private lazy var customView: PersonalDataScreen = {
        guard let view = view as? PersonalDataScreen else {
            fatalError("View is not of type PersonalDataScreen")
        }
        return view
    }()
    
    override func loadView() {
        super.loadView()
        view = PersonalDataScreen(textFieldDelegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PersonalDataViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        customView.goToNextField(textField) {
            print("Skip")
        }
        return true
    }
}
