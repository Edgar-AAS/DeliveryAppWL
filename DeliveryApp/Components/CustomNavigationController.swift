import UIKit

final class CustomNavigationController: UINavigationController {
    private var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setup()
    }
    
    private func setup() {
        navigationBar.barTintColor = Colors.backgroundColor
        navigationBar.tintColor = Colors.primaryColor
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}

