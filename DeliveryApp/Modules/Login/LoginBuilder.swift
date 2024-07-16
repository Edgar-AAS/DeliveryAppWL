//
//  LoginBuilder.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 30/01/24.
//

import Foundation

class LoginBuilder {
    static func build(coordinator: MainCoordinator) -> LoginViewController {
        let emailValidator = EmailValidatorAdapter()
        let userLogin = FirebaseSignIn()
        let viewModel = LoginViewModel(emailValidator: emailValidator,
                                       coordinator: coordinator,
                                       userLogin: userLogin)
        let viewController = LoginViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        viewModel.fieldDescription = viewController
        return viewController
    }
}
