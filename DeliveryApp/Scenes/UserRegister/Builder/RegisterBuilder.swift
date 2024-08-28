//
//  SignUpBuilder.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/01/24.
//

import Foundation

class RegisterBuilder {
    static func build(coordinator: Coordinator) -> RegisterViewController {
        let userRegister = FirebaseRegister()
        let emailValidator = EmailValidatorAdapter()
        let viewModel = RegisterViewModel(userRegister: userRegister, emailValidator: emailValidator, coordinator: coordinator)
        
        let viewController = RegisterViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        viewModel.fieldValidationDelegate = viewController
        return viewController
    }
}
