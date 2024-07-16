//
//  AuthCoordinator.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/01/24.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: CustomNavigationController? { get set }
    func start()
    func eventOcurred(type: Event)
}

enum Event: Equatable {
    case loginToRegister
    case registerToLogin
    case goToHome
    case goToFoodDetails(Food)
    case goToForgotPassword
    case goToEmailVerification(User)
    case backToHome

    static func ==(lhs: Event, rhs: Event) -> Bool {
        switch (lhs, rhs) {
        case (.loginToRegister, .loginToRegister):
            return true
        case (.registerToLogin, .registerToLogin):
            return true
        case (.goToHome, .goToHome):
            return true
        case (.goToForgotPassword, .goToForgotPassword):
            return true
        case (.backToHome, .backToHome):
            return true
        case (.goToFoodDetails(let lhsFood), .goToFoodDetails(let rhsFood)):
            return lhsFood == rhsFood
        case (.goToEmailVerification(let lhsUser), .goToEmailVerification(let rhsUser)):
            return lhsUser == rhsUser
        default:
            return false
        }
    }
}

class MainCoordinator: Coordinator {
    var navigationController: CustomNavigationController?
    
    func start() {
        let viewController = LoginBuilder.build(coordinator: self)
        navigationController?.setRootViewController(viewController)
    }
    
    func eventOcurred(type: Event) {
        switch type {
        case .loginToRegister:
            let viewController = SignUpBuilder.build(coordinator: self)
            navigationController?.pushViewController(viewController)
        case .registerToLogin:
            navigationController?.popViewController()
        case .goToHome:
            let viewController = HomeBuilder.build(coordinator: self)
            navigationController?.pushViewController(viewController)
        case .goToForgotPassword:
            let viewController = ForgotPasswordBuilder.build(coordinator: self)
            navigationController?.pushViewController(viewController)
        case .goToEmailVerification(let user):
            let viewController = EmailVerificationBuilder.build(coordinator: self, user: user)
            navigationController?.pushViewController(viewController)
        case .goToFoodDetails(let foodData):
            let viewController = FoodDetailsBuilder.build(coordinator: self, foodModel: foodData)
            navigationController?.pushViewController(viewController)
        case .backToHome:
            navigationController?.popViewController()
        }
    }
}
