//
//  LoginViewModel.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/01/24.
//

import Foundation


protocol LoginViewModelProtocol {
    func signIn(authenticationModel: AuthenticationModel)
    func goToSignUp()
    func goToHome()
    func goToForgotPassword()
}

class LoginViewModel: LoginViewModelProtocol {
    private let emailValidator: EmailValidator
    private let coordinator: Coordinator
    private let userLogin: LoginProtocol
    
    weak var fieldDescription: FieldDescriptionProtocol?
    weak var alertView: AlertView?
    
    init(emailValidator: EmailValidator,
         coordinator: Coordinator,
         userLogin: LoginProtocol
    )
    {
        self.emailValidator = emailValidator
        self.coordinator = coordinator
        self.userLogin = userLogin
    }
    
    func signIn(authenticationModel: AuthenticationModel) {
        if let viewModel = validateFields(loginUserRequest: authenticationModel) {
            self.fieldDescription?.showMessage(viewModel: viewModel)
        } else {
            userLogin.auth(authenticationModel: authenticationModel) { [weak self] result in
                guard self != nil else { return }
                
                switch result {
                case .success():
                    DispatchQueue.main.async { [weak self] in
                        self?.coordinator.eventOcurred(type: .goToHome)
                    }
                case .failure(_ ):
                    self?.alertView?.showMessage(viewModel: AlertViewModel(title: "Error", message: "Algo inesperado aconteceu, tente novamente em instantes."))
                }
            }
        }
    }
    
    func goToForgotPassword() {
        coordinator.eventOcurred(type: .goToForgotPassword)
    }
    
    func goToHome() {
        coordinator.eventOcurred(type: .goToHome)
    }
    
    func goToSignUp() {
        coordinator.eventOcurred(type: .loginToRegister)
    }
    
    private func validateFields(loginUserRequest: AuthenticationModel) -> FieldDescriptionViewModel? {
        if loginUserRequest.email.isEmpty {
            return .init(message: "O campo E-mail é obrigatório", fieldType: .email)
        } else if !emailValidator.isValid(email: loginUserRequest.email) {
            return .init(message: "O campo E-mail está inválido", fieldType: .email)
        } else if loginUserRequest.password.isEmpty {
            return .init(message: "O campo Senha é obrigatório", fieldType: .password)
        } else { return nil }
    }
}
