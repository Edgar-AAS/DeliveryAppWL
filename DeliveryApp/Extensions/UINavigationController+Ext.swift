import UIKit

private let _durationTime: CFTimeInterval = 0.25

public extension UINavigationController {
    enum VCTransition {
        case fromTop
        case fromBottom
    }

    func customPopViewController(direction: VCTransition = .fromTop, transitionType: CATransitionType = .push) {
        self.addTransition(transitionDirection: direction, transitionType: transitionType)
        self.popViewController(animated: false)
    }
    
    func popToViewController(ofClass: AnyClass, animated: Bool = true) {
      if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
        popToViewController(vc, animated: animated)
      }
    }
    
    func customPopToRootViewController(direction: VCTransition = .fromTop, transitionType: CATransitionType = .push) {
        self.addTransition(transitionDirection: direction, transitionType: transitionType)
        self.popToRootViewController(animated: false)
    }
    
    func customPopToViewController(viewController vc: UIViewController, direction: VCTransition = .fromTop, transitionType: CATransitionType = .push) {
        self.addTransition(transitionDirection: direction, transitionType: transitionType)
        self.popToViewController(vc, animated: false)
    }

    func customPushViewController(viewController vc: UIViewController, direction: VCTransition = .fromBottom, transitionType: CATransitionType = .push) {
        self.addTransition(transitionDirection: direction, transitionType: transitionType)
        self.pushViewController(vc, animated: false)
    }

    private func addTransition(transitionDirection direction: VCTransition, transitionType: CATransitionType = .push, duration: CFTimeInterval = _durationTime) {
        let transition = CATransition()
        transition.duration = duration
        transition.type = transitionType
        transition.timingFunction = .init(name: .easeInEaseOut)
        if direction == .fromBottom {
            transition.subtype = .fromBottom
        } else {
            transition.subtype = .fromTop
        }
        self.view.layer.add(transition, forKey: kCATransition)
    }
}

