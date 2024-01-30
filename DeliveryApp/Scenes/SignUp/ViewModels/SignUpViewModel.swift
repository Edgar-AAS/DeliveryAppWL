//
//  SignUpViewModel.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/01/24.
//

import Foundation

protocol SignUpViewModelProtocol {
    func createUserWith(userRequest: RegisterUserRequest, isCheked: Bool)
}

class SignUpViewModel: SignUpViewModelProtocol {
    private let addAccount: AddAccountProtocol
    private let emailValidator: EmailValidator
    private let coordinator: Coordinator
    weak var alertView: AlertView?
    
    init(addAccount: AddAccountProtocol, emailValidator: EmailValidator, coordinator: Coordinator) {
        self.addAccount = addAccount
        self.emailValidator = emailValidator
        self.coordinator = coordinator
    }
    
    func createUserWith(userRequest: RegisterUserRequest, isCheked: Bool) {
        if let message = validateFields(userRequest: userRequest, isCheked: isCheked) {
            alertView?.showMessage(viewModel: AlertViewModel(title: "Falha na validação", message: message))
        } else {
            addAccount.add(with: userRequest) { [weak self] wasRegistered, error in
                guard self != nil else { return }
                
                if let error = error {
                    self?.alertView?.showMessage(viewModel: AlertViewModel(title: "Error", message: error.localizedDescription))
                } else {
                    if wasRegistered {
                        self?.coordinator.eventOcurred(type: .goToLogin)
                    }
                }
            }
        }
    }

    private func validateFields(userRequest: RegisterUserRequest, isCheked: Bool) -> String? {
        if userRequest.email.isEmpty {
            return "O campo de E-mail é obrigatório"
        } else if !emailValidator.isValid(email: userRequest.email) {
            return "O campo de E-mail esta inválido"
        } else if userRequest.username.isEmpty {
            return "O campo de Nome do usuário é obrigatório"
        } else if userRequest.password.isEmpty {
            return "O campo de Senha é obrigatório"
        } else if !isCheked {
            return "To create your account, it is necessary to agree to the Terms of Service and Privacy Policy."
        } else { return nil }
    }
}

