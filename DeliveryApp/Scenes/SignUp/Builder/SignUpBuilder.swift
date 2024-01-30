//
//  SignUpBuilder.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/01/24.
//

import Foundation

class SignUpBuilder {
    static func build(coordinator: Coordinator) -> SignUpViewController {
        let addAccount = AddAccount()
        let emailValidator = EmailValidatorAdapter()
        let viewModel = SignUpViewModel(addAccount: addAccount, emailValidator: emailValidator, coordinator: coordinator)
        let viewController = SignUpViewController(viewModel: viewModel)
        viewModel.alertView = viewController
        return viewController
    }
}
