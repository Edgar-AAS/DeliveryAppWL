//
//  ForgotPasswordBuilder.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 03/06/24.
//

import Foundation

class ForgotPasswordBuilder {
    static func build(coordinator: Coordinator) -> ForgotPasswordViewController {
        let emailValidator = EmailValidatorAdapter()
        let passwordReset = FirebasePasswordReset()
        let viewModel = ForgotPasswordViewModel(passwordReset: passwordReset,
                                                emailValidator: emailValidator,
                                                coordinator: coordinator)
        let viewController = ForgotPasswordViewController(viewModel: viewModel)
        return viewController
    }
}
