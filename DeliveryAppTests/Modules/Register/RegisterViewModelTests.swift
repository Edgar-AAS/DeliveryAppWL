import XCTest
@testable import DeliveryApp

final class RegisterViewModelTests: XCTestCase {
    func test_create_user_should_call_with_correct_user_request() {
        let alertViewSpy = AlertViewSpy()
        let userRegisterSpy = UserRegisterSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy, alertViewSpy: alertViewSpy)
        
        let userRequest = makeRegisterUserRequest()
        sut.toggleTerms(assined: true)
        sut.createUser(userRequest: userRequest)
        XCTAssertEqual(userRegisterSpy.userRequest, userRequest)
    }
    
    func test_create_user_should_call_alert_view_with_generic_error_when_register_fails() {
        let alertViewSpy = AlertViewSpy()
        let userRegisterSpy = UserRegisterSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy, alertViewSpy: alertViewSpy)
                
        sut.toggleTerms(assined: true)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em instantes."))
            exp.fulfill()
        }
        
        sut.createUser(userRequest: makeRegisterUserRequest())
        userRegisterSpy.completeWithFailure()
        wait(for: [exp], timeout: 1)
    }
    
    func test_create_user_should_return_error_when_email_is_empty() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo E-mail é obrigatório", type: .email))
            exp.fulfill()
        }
        
        sut.createUser(userRequest: makeRegisterUserRequest(email: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_create_user_should_return_error_when_email_is_empty_and_password_is_provided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo E-mail é obrigatório", type: .email))
            exp.fulfill()
        }
        
        sut.createUser(userRequest: makeRegisterUserRequest(email: "", password: "any_password"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_create_user_should_return_error_when_email_is_invalid_and_password_is_empty() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo E-mail está inválido", type: .email))
            exp.fulfill()
        }
        
        emailValidatorSpy.completeWithFailure()
        sut.createUser(userRequest: makeRegisterUserRequest(email: "invalid.email", password: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_create_user_should_return_error_when_email_is_invalid_and_password_is_provided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo E-mail está inválido", type: .email))
            exp.fulfill()
        }
        
        emailValidatorSpy.completeWithFailure()
        sut.createUser(userRequest: makeRegisterUserRequest(email: "invalid.email", password: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_create_user_should_return_error_when_username_is_empty() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo Nome é obrigatório", type: .regular))
            exp.fulfill()
        }
        
        sut.createUser(userRequest: makeRegisterUserRequest(username: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_create_user_should_return_error_when_password_is_empty() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo Senha é obrigatório", type: .password))
            exp.fulfill()
        }
        
        sut.createUser(userRequest: makeRegisterUserRequest(password: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_create_user_should_return_error_when_confirm_password_is_empty() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo Confirmação de senha é obrigatório", type: .passwordConfirm))
            exp.fulfill()
        }
        
        sut.createUser(userRequest: makeRegisterUserRequest(confirmPassword: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_create_user_returns_error_when_passwords_do_not_match() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "Os campos de senha devem coincidir", type: .passwordConfirm))
            exp.fulfill()
        }
        
        sut.createUser(userRequest: makeRegisterUserRequest(password: "123456", confirmPassword: "5445667"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_create_user_returns_error_when_terms_of_service_not_accepted() {
        let userRegisterSpy = UserRegisterSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy, alertViewSpy: alertViewSpy)
            
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Para criar sua conta, confirme que você leu e concorda com os Termos de Serviço."))
            exp.fulfill()
        }
        
        sut.createUser(userRequest: makeRegisterUserRequest())
        wait(for: [exp], timeout: 1)
    }
    
    func test_create_user_should_call_coordinator_with_registerToLogin_type() {
        let coordinatorSpy = CoordinatorSpy()
        let userRegisterSpy = UserRegisterSpy()
        let sut = makeSut(coordinatorSpy: coordinatorSpy, userRegisterSpy: userRegisterSpy)
        
        sut.toggleTerms(assined: true)
    
        let exp = expectation(description: "waiting")
        coordinatorSpy.observe { eventType in
            XCTAssertEqual(eventType, .goToRegistrationSuccess(makeRegistrationSuccessModel()))
            exp.fulfill()
        }
        
        sut.createUser(userRequest: makeRegisterUserRequest())
        userRegisterSpy.completeWithSuccess()
        wait(for: [exp], timeout: 1)
    }
    
    func test_route_to_home_should_call_coordinator_with_goToHome_type() {
        let coordinatorSpy = CoordinatorSpy()
        let sut = makeSut(coordinatorSpy: coordinatorSpy)
    
        let exp = expectation(description: "waiting")
        coordinatorSpy.observe { eventType in
            XCTAssertEqual(eventType, .goToHome)
            exp.fulfill()
        }
        
        sut.routeToHome()
        wait(for: [exp], timeout: 1)
    }
    
    func test_register_to_login_should_call_coordinator_with_register_to_login_type() {
        let coordinatorSpy = CoordinatorSpy()
        let sut = makeSut(coordinatorSpy: coordinatorSpy)
        
        let exp = expectation(description: "waiting")
        coordinatorSpy.observe { eventType in
            XCTAssertEqual(eventType, .registerToLogin)
            exp.fulfill()
        }
        
        sut.routeToLogin()
        wait(for: [exp], timeout: 1)
    }
    
    func test_loadingHandler_startsWithTrue_and_switchesToFalse_when_registerFails() {
        let userRegisterSpy = UserRegisterSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy)
        
        sut.toggleTerms(assined: true)
        
        let exp = expectation(description: "waiting")
        sut.loadingHandler = { isLoading in
            XCTAssertTrue(isLoading)
            exp.fulfill()
        }
        
        sut.createUser(userRequest: makeRegisterUserRequest())
        
        let exp2 = expectation(description: "waiting")
        sut.loadingHandler = { isLoading in
            XCTAssertFalse(isLoading)
            exp2.fulfill()
        }
        
        userRegisterSpy.completeWithFailure()
        wait(for: [exp, exp2], timeout: 1)
    }
    
    func test_loadingHandler_startsWithTrue_and_switchesToFalse_when_registerSucceed() {
        let userRegisterSpy = UserRegisterSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy)
        
        sut.toggleTerms(assined: true)
        
        let exp = expectation(description: "waiting")
        sut.loadingHandler = { isLoading in
            XCTAssertTrue(isLoading)
            exp.fulfill()
        }
        
        sut.createUser(userRequest: makeRegisterUserRequest())
        
        let exp2 = expectation(description: "waiting")
        sut.loadingHandler = { isLoading in
            XCTAssertFalse(isLoading)
            exp2.fulfill()
        }
        
        userRegisterSpy.completeWithSuccess()
        wait(for: [exp, exp2], timeout: 1)
    }
}

extension RegisterViewModelTests {
    func makeSut(emailValidatorSpy: EmailValidatorSpy = EmailValidatorSpy(),
                 coordinatorSpy: CoordinatorSpy = CoordinatorSpy(),
                 userRegisterSpy: UserRegisterSpy = UserRegisterSpy(),
                 alertViewSpy: AlertViewSpy = AlertViewSpy(),
                 fieldDescriptionSpy: FieldDescriptionSpy = FieldDescriptionSpy(),
                 file: StaticString = #filePath, line: UInt = #line) -> RegisterViewModel
    {
        let sut = RegisterViewModel(userRegister: userRegisterSpy,
                                    emailValidator: emailValidatorSpy,
                                    coordinator: coordinatorSpy)
        
        sut.fieldValidationDelegate = fieldDescriptionSpy
        sut.alertView = alertViewSpy
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
