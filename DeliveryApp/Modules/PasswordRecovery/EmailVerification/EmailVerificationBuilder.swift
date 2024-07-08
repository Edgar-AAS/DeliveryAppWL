//
//  EmailVerificationBuilder.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 03/06/24.
//

import Foundation

class EmailVerificationBuilder {
    static func build(coordinator: Coordinator, user: User) -> EmailVerificationViewController {
        let passwordReset = FirebasePasswordReset()
        let viewModel = EmailVerificationViewModel(coordinator: coordinator, user: user, passwordReset: passwordReset)
        let viewController = EmailVerificationViewController(viewModel: viewModel)
        return viewController
    }
}
