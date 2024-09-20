import UIKit

class RegisterCoordinator: Coordinator {
    var navigationController: UINavigationController
    var childCoordinators = [Coordinator]()
    weak var parentCoordinator: LoginCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let registerViewController = RegisterBuilder.build()
        registerViewController.loginAction = { [weak self] in
            self?.navigateToLogin()
        }
        navigationController.pushViewController(registerViewController, animated: true)
    }
    
    func navigateToLogin() {
        // Verifica se a tela de login já está no navigation stack
        if let loginViewController = navigationController.viewControllers.first(where: { $0 is LoginViewController }) {
            // Se sim, retorna para a tela de login
            navigationController.popToViewController(loginViewController, animated: true)
        } else {
            // Caso contrário, cria um novo LoginCoordinator e inicia o fluxo de login
            let loginCoordinator = LoginCoordinator(navigationController: navigationController)
            loginCoordinator.parentCoordinator = parentCoordinator?.parentCoordinator
            parentCoordinator?.addChild(loginCoordinator)
            loginCoordinator.start()
        }
        
        parentCoordinator?.childDidFinish(self)
    }
    
    func navigateToSuccessScreen() {
        // Implemente a navegação para a tela de sucesso
    }
}
