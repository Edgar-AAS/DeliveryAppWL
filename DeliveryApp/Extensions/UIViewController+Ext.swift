import UIKit

extension UIViewController {
    func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func hideTabBar() {
        guard let tabBar = self.tabBarController?.tabBar else { return }
        
        UIView.animate(withDuration: 0.3) {
            tabBar.frame.origin.y = UIScreen.main.bounds.size.height
        }
    }
    
    func showAlertView(title: String, description: String = "", image: UIImage? = nil, onClose: (() -> Void)? = nil) {
        let alertView = AlertView(
            image: image ?? UIImage(systemName: SFSymbols.warning),
            title: title,
            descriptionText: description,
            onClose: onClose
        )
        alertView.showAlert(in: view)
    }
}
