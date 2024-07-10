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

enum Event {
    case loginToRegister
    case registerToLogin
    case goToHome
    case goToFoodDetails(Food)
    case goToForgotPassword
    case goToEmailVerification(User)
    case backToHome
}

class MainCoordinator: Coordinator {
    var navigationController: CustomNavigationController?
    
    func start() {
        let viewController = HomeBuilder.build(coordinator: self)
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
            let viewModel = FoodDetailsViewModel(foodModel: foodData, coordinator: self)
            let viewController = FoodDetailsViewController(viewModel: viewModel)
            viewModel.delegate = viewController
            navigationController?.pushViewController(viewController)
        case .backToHome:
            navigationController?.popViewController()
        }
    }
}
