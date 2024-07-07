//
//  LoginViewModel.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/01/24.
//

import Foundation


protocol LoginViewModelProtocol {
    func signIn(loginRequest: LoginUserRequest)
    func goToSignUp()
    func goToHome()
    func goToForgotPassword()
}

class LoginViewModel: LoginViewModelProtocol {
    private let emailValidator: EmailValidator
    private let coordinator: Coordinator
    private let userSignIn: SignInProtocol
    
    weak var alertView: AlertView?
    weak var fieldDescription: FieldDescription?
    
    init(emailValidator: EmailValidator,
         coordinator: Coordinator,
         userSignIn: SignInProtocol)
    {
        self.emailValidator = emailValidator
        self.coordinator = coordinator
        self.userSignIn = userSignIn
    }
    
    func signIn(loginRequest: LoginUserRequest) {
        if let viewModel = validateFields(loginUserRequest: loginRequest) {
            self.fieldDescription?.showMessage(viewModel: viewModel)
        } else {
            userSignIn.signIn(loginRequest: loginRequest) { [weak self] isLogged, error in
                guard self != nil else { return }
                
                if let error = error {
                    self?.alertView?.showMessage(viewModel: AlertViewModel(title: "Error", message: error.localizedDescription))
                } else {
                    if isLogged {
                        DispatchQueue.main.async { [weak self] in
                            self?.coordinator.eventOcurred(type: .goToHome)
                        }
                    }
                }
            }
            self.coordinator.eventOcurred(type: .goToHome)
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
    
    private func validateFields(loginUserRequest: LoginUserRequest) -> FieldDescriptionViewModel? {
        if loginUserRequest.email.isEmpty {
            return .init(message: "O campo E-mail é obrigatório", fieldType: .email)
        } else if !emailValidator.isValid(email: loginUserRequest.email) {
            return .init(message: "O campo E-mail esta inválido", fieldType: .email)
        } else if loginUserRequest.password.isEmpty {
            return .init(message: "O campo Senha é obrigatório", fieldType: .password)
        } else { return nil }
    }
}
