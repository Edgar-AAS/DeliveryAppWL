import UIKit

class CustomNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
       setup()
    }
    
    private func setup() {
        navigationBar.barStyle = .black
        navigationBar.barTintColor = .white
        navigationBar.tintColor = .black
    }
    
    func pushViewController(_ viewController: UIViewController) {
        pushViewController(viewController, animated: true)
    }
    
    func setRootViewController(_ viewController: UIViewController) {
        setViewControllers([viewController], animated: true)
    }
    
    func popViewController() {
        popViewController(animated: true)
    }
}

