//
//  SignUpViewModel.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/01/24.
//

import Foundation

protocol SignUpViewModelProtocol {
    func createUserWith(userRequest: RegisterUserRequest, isCheked: Bool)
    func routeToLogin()
}

class SignUpViewModel: SignUpViewModelProtocol {
    private let userSignUp: SignUpProtocol
    private let emailValidator: EmailValidator
    private let coordinator: Coordinator
    
    weak var alertView: AlertView?
    weak var fieldDescription: FieldDescriptionProtocol?
    
    init(userSignUp: SignUpProtocol,
         emailValidator: EmailValidator,
         coordinator: Coordinator)
    {
        self.userSignUp = userSignUp
        self.emailValidator = emailValidator
        self.coordinator = coordinator
    }
    
    func createUserWith(userRequest: RegisterUserRequest, isCheked: Bool) {
        if let viewModel = validateFields(userRequest: userRequest, isCheked: isCheked) {
            fieldDescription?.showMessage(viewModel: viewModel)
        } else {
            userSignUp.signUp(userRequest: userRequest) { [weak self] wasRegistered, error in
                guard self != nil else { return }
                
                DispatchQueue.main.async {
                    if let error = error {
                        self?.alertView?.showMessage(viewModel: AlertViewModel(title: "Error", message: error.localizedDescription))
                    } else {
                        if wasRegistered {
                            self?.coordinator.eventOcurred(type: .registerToLogin)
                        }
                    }
                }
            }
        }
    }
    
    
    func routeToLogin() {
        coordinator.eventOcurred(type: .registerToLogin)
    }
    
    private func validateFields(userRequest: RegisterUserRequest, isCheked: Bool) -> FieldDescriptionViewModel? {
        if userRequest.email.isEmpty {
            return FieldDescriptionViewModel(message: "O campo E-mail é obrigatório", fieldType: .email)
        } else if !emailValidator.isValid(email: userRequest.email) {
            return FieldDescriptionViewModel(message: "O campo E-mail esta inválido", fieldType: .email)
        } else if userRequest.username.isEmpty {
            return FieldDescriptionViewModel(message: "O campo Nome do usuário é obrigatório", fieldType: .regular)
        } else if userRequest.password.isEmpty {
            return FieldDescriptionViewModel(message: "O campo Senha é obrigatório", fieldType: .password)
        } else if userRequest.confirmPassword.isEmpty {
            return FieldDescriptionViewModel(message: "O campo Confirmação de senha é obrigatório", fieldType: .passwordConfirm)
        } else if userRequest.password != userRequest.confirmPassword {
            return FieldDescriptionViewModel(message: "Os campos de senha devem coincidir", fieldType: .passwordConfirm)
        } else if !isCheked {
            return FieldDescriptionViewModel(message: "", fieldType: .regular)
        } else { return nil }
    }
}

