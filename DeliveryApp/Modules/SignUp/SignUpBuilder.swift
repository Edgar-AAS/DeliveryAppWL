//
//  SignUpBuilder.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/01/24.
//

import Foundation

class SignUpBuilder {
    static func build(coordinator: Coordinator) -> SignUpViewController {
        let authenticationManager = FirebaseSignUp()
        let emailValidator = EmailValidatorAdapter()
        let viewModel = SignUpViewModel(userSignUp: authenticationManager, emailValidator: emailValidator, coordinator: coordinator)
        let viewController = SignUpViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        viewModel.fieldDescription = viewController
        return viewController
    }
}
