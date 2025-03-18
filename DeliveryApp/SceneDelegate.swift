import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        let appWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
        appWindow.windowScene = windowScene
        
        let navigationController = DANavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        
        let coordinator = MainCoordinator(navigationController: navigationController)
        appWindow.rootViewController = CartViewController()
        appWindow.makeKeyAndVisible()
        coordinator.start()
        window = appWindow
    }
}
