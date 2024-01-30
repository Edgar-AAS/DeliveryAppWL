//
//  LoginViewModel.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/01/24.
//

import Foundation

protocol LoginViewModelProtocol {
    func signIn(loginUserRequest: LoginUserRequest)
}

class LoginViewModel: LoginViewModelProtocol {
    private let emailValidator: EmailValidator
    private let coordinator: Coordinator
    private let loginAccount: LoginAccountProtocol
    weak var alertView: AlertView?
    
    init(emailValidator: EmailValidator, coordinator: Coordinator, loginAccount: LoginAccountProtocol) {
        self.emailValidator = emailValidator
        self.coordinator = coordinator
        self.loginAccount = loginAccount
    }
    
    func signIn(loginUserRequest: LoginUserRequest) {
        loginAccount.signInWith(loginRequest: loginUserRequest) { isLogged, error in
            print(isLogged)
        }
    }
}
