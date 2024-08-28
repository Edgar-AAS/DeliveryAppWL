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
    
    func pushViewController(_ viewController: UIViewController) {
        pushViewController(viewController, animated: true)
        hideBackButtonText()
    }
       
    func setRootViewController(_ viewController: UIViewController) {
        setViewControllers([viewController], animated: true)
        currentViewController = viewController
        hideBackButtonText()
    }
    
    func popViewController() {
        popViewController(animated: true)
    }
    
    func pop(to viewController: UIViewController) {
        popToViewController(viewController, animated: true)
    }
    
    public func hideBackButtonText() {
        currentViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
}

