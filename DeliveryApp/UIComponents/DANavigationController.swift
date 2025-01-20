import UIKit

final class DANavigationController: UINavigationController {
    private var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       setup()
    }
    
    private func setup() {
        navigationBar.barTintColor = Colors.background
        navigationBar.tintColor = Colors.primary
        navigationBar.shadowImage = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}

