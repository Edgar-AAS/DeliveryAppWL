import Foundation

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
