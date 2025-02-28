import UIKit

final class MainTabBarController: UITabBarController {
    weak var coordinator: MainCoordinator?
    
    private let homeCoordinator = HomeCoordinator(navigationController: DANavigationController())
    private let profileDataCoordinator = ProfileDataCoordinator(navigationController: DANavigationController())
    
    init(coordinator: MainCoordinator? = nil) {
        self.coordinator = coordinator
        super.init(nibName: "BaseTabBarController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTabBarAppearance()
        
        homeCoordinator.parentCoordinator = coordinator
        profileDataCoordinator.parentCoordinator = coordinator

        for item in [homeCoordinator, profileDataCoordinator] {
            coordinator?.addChild(item as? Coordinator)
        }
        
        homeCoordinator.start()
        profileDataCoordinator.start()
        
        viewControllers = [homeCoordinator.navigationController, profileDataCoordinator.navigationController]
    }
    
    private func configureTabBarAppearance() {
        tabBar.tintColor = .primary1
        tabBar.backgroundColor = .white
        tabBar.unselectedItemTintColor = .gray
        tabBar.layer.shadowColor = UIColor.black.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        tabBar.layer.shadowRadius = 4
        tabBar.layer.shadowOpacity = 0.3
        tabBar.layer.masksToBounds = false
        tabBar.layer.cornerRadius = 8
    }
    
    func hideNavigationController() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
