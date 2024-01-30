//
//  AuthCoordinator.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/01/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController? { get set }
    func start()
    func eventOcurred(type: Event)
}

enum Event {
    case goToLogin
    case goToSignUp
    case goToHome
}

class AuthCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    func start() {
        let viewController = SignUpBuilder.build(coordinator: self)
        navigationController?.setViewControllers([viewController], animated: true)
    }
        
    func eventOcurred(type: Event) {
        switch type {
        case .goToLogin:
            navigationController?.popViewController(animated: true)
        case .goToSignUp:
            return
        case .goToHome:
            return
        }
    }
}
