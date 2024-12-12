import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
        appWindow.windowScene = windowScene
        
        let navigationController = CustomNavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        let coordinator = MainCoordinator(navigationController: navigationController)
        coordinator.start()
        
        
        let httpClient = HTTPClient()
        let updateProfile = UpdateProfile(httpClient: httpClient)
        let viewModel = PersonalDataViewModel(updateProfile: updateProfile)
        
        appWindow.rootViewController = PersonalDataViewController(viewModel: viewModel)
        appWindow.makeKeyAndVisible()
        window = appWindow
    }
}
