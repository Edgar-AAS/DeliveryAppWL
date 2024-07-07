//
//  ForgotPasswordViewModel.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 25/05/24.
//

import Foundation


protocol ForgotPasswordViewModelProtocol: AnyObject {
    func sendPasswordReset(with userRequest: ForgotPasswordUserRequest)
}

class ForgotPasswordViewModel: ForgotPasswordViewModelProtocol {
    private let passwordReset: PasswordResetProtocol
    private let emailValidator: EmailValidator
    private let coordinator: Coordinator
        
    init(passwordReset: PasswordResetProtocol,
         emailValidator: EmailValidator,
         coordinator: Coordinator) {
        
        self.passwordReset = passwordReset
        self.emailValidator = emailValidator
        self.coordinator = coordinator
    }
    
    func sendPasswordReset(with userRequest: ForgotPasswordUserRequest) {
        if emailValidator.isValid(email: userRequest.email) {
            passwordReset.sendPasswordResetWith(userRequest: userRequest) { [weak self] isSucceeds, error in
                if isSucceeds {
                    let user = User(email: userRequest.email)
                    self?.coordinator.eventOcurred(type: .goToEmailVerification(user))
                }
            }
        }
    }
}
