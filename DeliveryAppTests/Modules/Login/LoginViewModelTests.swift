//
//  LoginViewModelTests.swift
//  DeliveryAppTests
//
//  Created by Edgar Arlindo on 15/07/24.
//

import XCTest
@testable import DeliveryApp

final class LoginViewModelTests: XCTestCase {
    func test_sign_in_should_call_auth_with_correct_authentication_model() {
        let userLoginSpy = UserLoginSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy)
        let authenticationModel = makeAuthenticationModel(email: "email@gmail.com", password: "123456")
        sut.signIn(loginRequest: authenticationModel)
        XCTAssertEqual(userLoginSpy.authenticationModel, authenticationModel)
    }
    
    func test_sign_in_should_return_error_when_email_is_empty() {
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo E-mail é obrigatório", type: .email))
            exp.fulfill()
        }
        
        sut.signIn(loginRequest: makeAuthenticationModel(email: "", password: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_sign_in_should_return_error_when_email_is_empty_and_password_is_provided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo E-mail é obrigatório", type: .email))
            exp.fulfill()
        }
    
        sut.signIn(loginRequest: makeAuthenticationModel(email: "", password: "password"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_sign_in_should_return_error_when_email_is_invalid_and_password_is_empty() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo E-mail está inválido", type: .email))
            exp.fulfill()
        }
        
        emailValidatorSpy.completeWithFailure()
        sut.signIn(loginRequest: makeAuthenticationModel(email: "invalid.email", password: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_sign_in_should_return_error_when_email_is_invalid_and_password_is_provided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo E-mail está inválido", type: .email))
            exp.fulfill()
        }
        
        emailValidatorSpy.completeWithFailure()
        sut.signIn(loginRequest: makeAuthenticationModel(email: "invalid.email", password: "password"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_sign_in_should_return_error_when_password_is_empty_and_email_is_valid() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo Senha é obrigatório", type: .password))
            exp.fulfill()
        }
        
        emailValidatorSpy.completeWithValidEmail()
        sut.signIn(loginRequest: makeAuthenticationModel(email: "valid_email@gmail.com", password: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_sign_in_should_call_coordinator_with_correct_event_type() {
        let coordinatorSpy = CoordinatorSpy()
        let userLoginSpy = UserLoginSpy()
        let sut = makeSut(coordinatorSpy: coordinatorSpy, userLoginSpy: userLoginSpy)
        let authenticationModel = makeAuthenticationModel(email: "email@gmail.com", password: "123456")
        
        sut.signIn(loginRequest: authenticationModel)
        
        let exp = expectation(description: "waiting")
        coordinatorSpy.observe { eventType in
            XCTAssertEqual(eventType, .goToHome)
            exp.fulfill()
        }
        
        userLoginSpy.completeWithSuccess()
        wait(for: [exp], timeout: 1)
    }
    
    func test_go_to_forgot_password_should_call_coordinator_with_correct_event_type() {
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
    
    func test_go_to_home_should_call_coordinator_with_correct_event_type() {
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
    
    func test_go_to_sign_up_should_call_coordinator_with_correct_event_type() {
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
    
    func test_sign_in_should_show_generic_error_message_on_login_failure() {
        let userLoginSpy = UserLoginSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy, alertViewSpy: alertViewSpy)
        
        let authenticationModel = makeAuthenticationModel(email: "email@gmail.com", password: "123456")
        
        sut.signIn(loginRequest: authenticationModel)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em instantes."))
            exp.fulfill()
        }
        
        userLoginSpy.completeWithFailure()
        wait(for: [exp], timeout: 1)
    }
        
    func test_loadingHandler_startsWithTrue_and_switchesToFalse_when_authenticationFails() {
        let userLoginSpy = UserLoginSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy)
        
        let exp = expectation(description: "waiting")
        sut.loadingHandler = { isLoading in
            XCTAssertTrue(isLoading)
            exp.fulfill()
        }
        
        sut.signIn(loginRequest: makeAuthenticationModel())
        
        let exp2 = expectation(description: "waiting")
        sut.loadingHandler = { isLoading in
            XCTAssertFalse(isLoading)
            exp2.fulfill()
        }
        
        userLoginSpy.completeWithFailure()
        
        wait(for: [exp, exp2], timeout: 1)
    }
    
    func test_loadingHandler_startsWithTrue_and_switchesToFalse_when_authenticationSucceed() {
        let userLoginSpy = UserLoginSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy)
        
        let exp = expectation(description: "waiting")
        sut.loadingHandler = { isLoading in
            XCTAssertTrue(isLoading)
            exp.fulfill()
        }
        
        sut.signIn(loginRequest: makeAuthenticationModel())
        
        let exp2 = expectation(description: "waiting")
        sut.loadingHandler = { isLoading in
            XCTAssertFalse(isLoading)
            exp2.fulfill()
        }
        
        userLoginSpy.completeWithSuccess()
        wait(for: [exp, exp2], timeout: 1)
    }

}

extension LoginViewModelTests {
    func makeSut(emailValidatorSpy: EmailValidatorSpy = EmailValidatorSpy(),
                 coordinatorSpy: CoordinatorSpy = CoordinatorSpy(),
                 userLoginSpy: UserLoginSpy = UserLoginSpy(),
                 alertViewSpy: AlertViewSpy = AlertViewSpy(),
                 fieldDescriptionSpy: FieldDescriptionSpy = FieldDescriptionSpy(),
                 file: StaticString = #filePath, line: UInt = #line) -> LoginViewModel
    {
        let sut = LoginViewModel(coordinator: coordinatorSpy,
                                 authentication: userLoginSpy,
                                 emailValidation: emailValidatorSpy)
        sut.fieldValidationDelegate = fieldDescriptionSpy
        sut.alertView = alertViewSpy
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
