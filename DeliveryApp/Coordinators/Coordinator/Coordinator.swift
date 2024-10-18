import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func childDidFinish(_ child: Coordinator?)
    func addChild(_ child: Coordinator?)
    func start()
}

extension Coordinator {
    func addChild(_ child: Coordinator?){
        if let _child = child {
            childCoordinators.append(_child)
        }
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}
