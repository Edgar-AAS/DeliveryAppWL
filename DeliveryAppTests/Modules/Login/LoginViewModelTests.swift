//
//  LoginViewModelTests.swift
//  DeliveryAppTests
//
//  Created by Edgar Arlindo on 15/07/24.
//

import XCTest
@testable import DeliveryApp

final class LoginViewModelTests: XCTestCase {
    func test_signIn_shouldReturnErrorWhenEmailIsEmpty() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescription: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldDescriptionViewModel(message: "O campo E-mail é obrigatório", fieldType: .email))
            exp.fulfill()
        }
        
        sut.signIn(authenticationModel: makeAuthenticationModel(email: "", password: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signIn_shouldReturnErrorWhenEmailIsEmptyAndPasswordIsProvided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescription: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldDescriptionViewModel(message: "O campo E-mail é obrigatório", fieldType: .email))
            exp.fulfill()
        }
        
        sut.signIn(authenticationModel: makeAuthenticationModel(email: "", password: "password"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signIn_shouldReturnErrorWhenEmailIsInvalidAndPasswordIsEmpty() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescription: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldDescriptionViewModel(message: "O campo E-mail está inválido", fieldType: .email))
            exp.fulfill()
        }
        
        emailValidatorSpy.completeWithFailure()
        sut.signIn(authenticationModel: makeAuthenticationModel(email: "invalid.email", password: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signIn_shouldReturnErrorWhenEmailIsInvalidAndPasswordIsProvided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescription: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldDescriptionViewModel(message: "O campo E-mail está inválido", fieldType: .email))
            exp.fulfill()
        }
        
        emailValidatorSpy.completeWithFailure()
        sut.signIn(authenticationModel: makeAuthenticationModel(email: "invalid.email", password: "password"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signIn_shouldReturnErrorWhenPasswordIsEmptyAndEmailIsValid() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescription: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldDescriptionViewModel(message: "O campo Senha é obrigatório", fieldType: .password))
            exp.fulfill()
        }
        
        emailValidatorSpy.completeWithValidEmail()
        sut.signIn(authenticationModel: makeAuthenticationModel(email: "valid_email@gmail.com", password: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_signIn_shouldCallAuthWithCorrectAuthenticationModel() {
        let userLoginSpy = UserLoginSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy)
        let authenticationModel = makeAuthenticationModel(email: "email@gmail.com", password: "123456")
        sut.signIn(authenticationModel: authenticationModel)
        XCTAssertEqual(userLoginSpy.authenticationModel, authenticationModel)
    }
    
    func test_signIn_shouldCallCoordinatorWithCorrectEventType() {
        let coordinatorSpy = CoordinatorSpy()
        let userLoginSpy = UserLoginSpy()
        let sut = makeSut(coordinatorSpy: coordinatorSpy, userLoginSpy: userLoginSpy)
        let authenticationModel = makeAuthenticationModel(email: "email@gmail.com", password: "123456")
        
        sut.signIn(authenticationModel: authenticationModel)
        
        let exp = expectation(description: "waiting")
        
        coordinatorSpy.observe { eventType in
            XCTAssertEqual(eventType, .goToHome)
            exp.fulfill()
        }
        
        userLoginSpy.completeWithSuccess()
        wait(for: [exp], timeout: 1)
    }
    
    func test_goToForgotPassword_shouldCallCoordinatorWithCorrectEventType() {
        let userLoginSpy = UserLoginSpy()
        let coordinatorSpy = CoordinatorSpy()
        let sut = makeSut(coordinatorSpy: coordinatorSpy, userLoginSpy: userLoginSpy)
        
        let exp = expectation(description: "waiting")
        
        coordinatorSpy.observe { eventType in
            XCTAssertEqual(eventType, .goToForgotPassword)
            exp.fulfill()
        }
        
        sut.goToForgotPassword()
        wait(for: [exp], timeout: 1)
    }
    
    func test_goToHome_shouldCallCoordinatorWithCorrectEventType() {
        let userLoginSpy = UserLoginSpy()
        let coordinatorSpy = CoordinatorSpy()
        let sut = makeSut(coordinatorSpy: coordinatorSpy, userLoginSpy: userLoginSpy)
        
        let exp = expectation(description: "waiting")
        
        coordinatorSpy.observe { eventType in
            XCTAssertEqual(eventType, .goToHome)
            exp.fulfill()
        }
        
        sut.goToHome()
        wait(for: [exp], timeout: 1)
    }
    
    func test_goToSignUp_shouldCallCoordinatorWithCorrectEventType() {
        let userLoginSpy = UserLoginSpy()
        let coordinatorSpy = CoordinatorSpy()
        let sut = makeSut(coordinatorSpy: coordinatorSpy, userLoginSpy: userLoginSpy)
        
        let exp = expectation(description: "waiting")
        
        coordinatorSpy.observe { eventType in
            XCTAssertEqual(eventType, .loginToRegister)
            exp.fulfill()
        }
        
        sut.goToSignUp()
        wait(for: [exp], timeout: 1)
    }
    
    func test_signIn_shouldShowGenericErrorMessageOnLoginFailure() {
        let userLoginSpy = UserLoginSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy, alertViewSpy: alertViewSpy)
        
        let authenticationModel = makeAuthenticationModel(email: "email@gmail.com", password: "123456")
        
        sut.signIn(authenticationModel: authenticationModel)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Error", message: "Algo inesperado aconteceu, tente novamente em instantes."))
            exp.fulfill()
        }
        
        userLoginSpy.completeWithFailure()
        wait(for: [exp], timeout: 1)
    }
}

extension LoginViewModelTests {
    func makeSut(emailValidatorSpy: EmailValidatorSpy = EmailValidatorSpy(),
                 coordinatorSpy: CoordinatorSpy = CoordinatorSpy(),
                 userLoginSpy: UserLoginSpy = UserLoginSpy(),
                 alertViewSpy: AlertViewSpy = AlertViewSpy(),
                 fieldDescription: FieldDescriptionSpy = FieldDescriptionSpy(),
                 file: StaticString = #filePath, line: UInt = #line) -> LoginViewModel
    {
        let sut = LoginViewModel(emailValidator: emailValidatorSpy,
                                 coordinator: coordinatorSpy,
                                 userLogin: userLoginSpy)
        sut.fieldDescription = fieldDescription
        sut.alertView = alertViewSpy
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
