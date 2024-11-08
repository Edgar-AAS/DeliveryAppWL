import UIKit

extension UIViewController {
    func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func makeAlertVIew(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        return alert
    }
    
    func hideTabBar() {
        guard let tabBar = self.tabBarController?.tabBar else { return }
        
        UIView.animate(withDuration: 0.3) {
            tabBar.frame.origin.y = UIScreen.main.bounds.size.height
        }
    }
}
