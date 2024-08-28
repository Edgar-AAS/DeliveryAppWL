//
//  TestsFactories.swift
//  DeliveryAppTests
//
//  Created by Edgar Arlindo on 15/07/24.
//

import Foundation
@testable import DeliveryApp

func makeAuthenticationModel(email: String = "valid_email@gmail.com",
                             password: String = "Any_Password") -> LoginRequest {
    
    return LoginRequest(email: email, password: password)
}

func makeRegisterUserRequest(email: String = "valid_email@gmail.com",
                             username: String = "Any_Name",
                             password: String = "Any_Password",
                             confirmPassword: String = "Any_Password") -> RegisterUserRequest {
    
    return RegisterUserRequest(email: email,
                               username: username,
                               password: password,
                               confirmPassword: confirmPassword)
}

func makeRegistrationSuccessModel() -> RegistrationSuccessModel {
    return RegistrationSuccessModel(
        image: "Illustration-Success",
        title: "Sua conta foi criada com sucesso!",
        description: "Agora você pode entrar em sua conta com email e senha cadastradas.",
        buttonTitle: "Verify Account"
    )
}
