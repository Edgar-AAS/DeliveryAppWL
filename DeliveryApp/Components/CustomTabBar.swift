
import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        // Criação dos ViewControllers das abas
        let homeViewController = HomeBuilder.build()
        
        // Configuração dos ícones e títulos da TabBar
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 0)
        
        // Adicionando os ViewControllers na TabBar
        viewControllers = []
        
        // Configuração adicional da TabBar (opcional)
        tabBar.tintColor = .systemBlue
        tabBar.barTintColor = .white
        tabBar.isTranslucent = false
    }
}
