import UIKit

final class ProfileDataCoordinator: Coordinator {
    var navigationController: UINavigationController
    var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let updateProfileDataController = ProfileDataBuilder.build(userId: 10)
        navigationController.pushViewController(updateProfileDataController, animated: true)
    }
}
