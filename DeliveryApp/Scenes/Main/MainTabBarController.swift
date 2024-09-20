import UIKit

final class MainTabBarController: UITabBarController {
    weak var coordinator: MainCoordinator?
    
    private let homeCoordinator = HomeCoordinator(navigationController: CustomNavigationController())
    
    init(coordinator: MainCoordinator? = nil) {
        self.coordinator = coordinator
        super.init(nibName: "BaseTabBarController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeCoordinator.parentCoordinator = coordinator
        tabBar.tintColor = Colors.primaryColor
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = .gray

        viewControllers = [homeCoordinator.navigationController]
        
        for item in [homeCoordinator] {
            coordinator?.addChild(item)
        }
        
        homeCoordinator.start()
        viewControllers = [homeCoordinator.navigationController]
    }
    
    func hideNavigationController() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
