import XCTest
@testable import DeliveryApp

final class RegisterViewModelTests: XCTestCase {
    func test_create_user_should_call_with_correct_user_request() {
        let alertViewSpy = AlertViewSpy()
        let createAccountSpy = CreateAccountUseCaseSpy()
        let sut = makeSut(userRegisterSpy: createAccountSpy, alertViewSpy: alertViewSpy)
        
        let userRequest = makeRegisterUserRequest(
            email: "any_email@gmail.com",
            username: "any_name",
            password: "any_password",
            confirmPassword: "any_password"
        )
        
        sut.toggleTerms(assined: true)
        
        let accountModel = CreateAccountModel(
            name: "any_name",
            email: "any_email@gmail.com",
            password: "any_password"
        )
        
        sut.createUser(userRequest: userRequest)
        XCTAssertEqual(createAccountSpy.userRequest, accountModel)
    }
    
    func test_create_user_should_call_alert_view_with_generic_error_when_register_fails() {
        let alertViewSpy = AlertViewSpy()
        let userRegisterSpy = CreateAccountUseCaseSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy, alertViewSpy: alertViewSpy)
                
        sut.toggleTerms(assined: true)
        
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro",
                                                     message: "Algo inesperado aconteceu, tente novamente em instantes."))
            exp.fulfill()
        }
        
        sut.createUser(userRequest: makeRegisterUserRequest())
        userRegisterSpy.completeWithFailure(httpError: .badRequest)
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
        let userRegisterSpy = CreateAccountUseCaseSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy, alertViewSpy: alertViewSpy)
            
        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(
                title: "Falha na validação",
                message: "Para criar sua conta, confirme que você leu e concorda com os Termos de Serviço.")
            )
            exp.fulfill()
        }
        
        sut.createUser(userRequest: makeRegisterUserRequest())
        wait(for: [exp], timeout: 1)
    }
    
    func test_loadingHandler_startsWithTrue_and_switchesToFalse_when_registerFails() {
        let userRegisterSpy = CreateAccountUseCaseSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy)
        
        sut.toggleTerms(assined: true)
        
        var loadingStates = [Bool]()
        let exp = expectation(description: "waiting for loading states")
        
        sut.loadingHandler = { state in
            loadingStates.append(state.isLoading)
            
            if loadingStates.count == 2 {
                exp.fulfill()
            }
        }
        
        sut.createUser(userRequest: makeRegisterUserRequest())
        
        userRegisterSpy.completeWithFailure(httpError: .badRequest)
        wait(for: [exp], timeout: 1)
        
        XCTAssertEqual(loadingStates, [true, false])
    }

    func test_loadingHandler_startsWithTrue_and_switchesToFalse_when_registerSucceed() {
        let userRegisterSpy = CreateAccountUseCaseSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy)
        
        sut.toggleTerms(assined: true)
        
        var loadingStates = [Bool]()
        let exp = expectation(description: "waiting for loading states")
        
        sut.loadingHandler = { state in
            loadingStates.append(state.isLoading)
            
            if loadingStates.count == 2 {
                exp.fulfill()
            }
        }
        
        sut.createUser(userRequest: makeRegisterUserRequest())
        
        userRegisterSpy.completeWithSuccess(reponse: .init(message: "Conta criada com sucesso"))
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(loadingStates, [true, false])
    }
}

extension RegisterViewModelTests {
    func makeSut(emailValidatorSpy: EmailValidatorSpy = EmailValidatorSpy(),
                 userRegisterSpy: CreateAccountUseCaseSpy = CreateAccountUseCaseSpy(),
                 alertViewSpy: AlertViewSpy = AlertViewSpy(),
                 fieldDescriptionSpy: FieldDescriptionSpy = FieldDescriptionSpy(),
                 file: StaticString = #filePath, line: UInt = #line) -> RegisterViewModel
    {
        let sut = RegisterViewModel(emailValidator: emailValidatorSpy, createAccount: userRegisterSpy)
        
        sut.fieldValidationDelegate = fieldDescriptionSpy
        sut.alertView = alertViewSpy
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
