//
//  LoginAccountContracts.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 06/03/25.
//

import Foundation

//MARK: - ViewModel
protocol LoginViewModelProtocol: LoadingHandler {
    func login(credential: LoginAccountRequest)
    var loginSuccess: (() -> Void)? { get set }
}

//MARK: - LoginScreen
protocol LoginScreenDelegate: AnyObject {
    func signInButtonDidTapped(_ view: LoginScreen)
    func registerButtonDidTapped(_ view: LoginScreen)
}
