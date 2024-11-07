import XCTest
@testable import DeliveryApp

final class RegisterViewModelTests: XCTestCase {
    func test_createUser_shouldCallCreateAccountWithCorrectData() {
        let alertViewSpy = AlertViewSpy()
        let createAccountSpy = CreateAccountUseCaseSpy()
        let sut = makeSut(userRegisterSpy: createAccountSpy, alertViewSpy: alertViewSpy)
        let accountModel = CreateAccountModel(
            name: "any_name",
            email: "any_email@gmail.com",
            password: "any_password"
        )
        
        sut.toggleTerms(assined: true)
        sut.createUser(userRequest: makeRegisterUserRequest(
            email: "any_email@gmail.com",
            username: "any_name",
            password: "any_password",
            confirmPassword: "any_password"
        ))
        
        XCTAssertEqual(createAccountSpy.userRequest, accountModel)
    }
    
    func test_createUser_shouldShowGenericError_whenRegisterFails() {
        let alertViewSpy = AlertViewSpy()
        let userRegisterSpy = CreateAccountUseCaseSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy, alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro",
                                                   message: "Algo inesperado aconteceu, tente novamente em instantes."))
            exp.fulfill()
        }
        
        sut.toggleTerms(assined: true)
        sut.createUser(userRequest: makeRegisterUserRequest())
        userRegisterSpy.completeWithFailure(httpError: .badRequest)
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_createUser_shouldReturnError_whenEmailIsEmpty() {
        let fieldValidationDelegateSpy = FieldDescriptionSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, fieldValidationDelegate: fieldValidationDelegateSpy)
        
        let exp = expectation(description: "waiting")
        
        fieldValidationDelegateSpy.observe { viewModel in
            XCTAssertEqual(viewModel, ValidationFieldModel(message: "O campo E-mail é obrigatório", type: .email))
            exp.fulfill()
        }
        
        validationSpy.simulateError(ValidationFieldModel(message: "O campo E-mail é obrigatório", type: .email))
        sut.createUser(userRequest: makeRegisterUserRequest(email: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_createUser_shouldReturnError_whenEmailIsEmptyAndPasswordIsProvided() {
        let fieldValidationDelegateSpy = FieldDescriptionSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, fieldValidationDelegate: fieldValidationDelegateSpy)
        
        let exp = expectation(description: "waiting")
        
        fieldValidationDelegateSpy.observe { viewModel in
            XCTAssertEqual(viewModel, ValidationFieldModel(message: "O campo E-mail é obrigatório", type: .email))
            exp.fulfill()
        }
        
        validationSpy.simulateError(ValidationFieldModel(message: "O campo E-mail é obrigatório", type: .email))
        
        sut.createUser(userRequest: makeRegisterUserRequest(email: "", password: "any_password"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_createUser_shouldReturnError_whenEmailIsInvalidAndPasswordIsEmpty() {
        let fieldValidationDelegateSpy = FieldDescriptionSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, fieldValidationDelegate: fieldValidationDelegateSpy)
        
        let exp = expectation(description: "waiting")
        
        fieldValidationDelegateSpy.observe { viewModel in
            XCTAssertEqual(viewModel, ValidationFieldModel(message: "O campo E-mail está inválido", type: .email))
            exp.fulfill()
        }
        
        validationSpy.simulateError(ValidationFieldModel(message: "O campo E-mail está inválido", type: .email))
        sut.createUser(userRequest: makeRegisterUserRequest(email: "invalid.email", password: ""))
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_createUser_shouldReturnError_whenEmailIsInvalidAndPasswordIsProvided() {
        let fieldValidationDelegateSpy = FieldDescriptionSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, fieldValidationDelegate: fieldValidationDelegateSpy)
        
        let exp = expectation(description: "waiting")
        
        fieldValidationDelegateSpy.observe { viewModel in
            XCTAssertEqual(viewModel, ValidationFieldModel(message: "O campo E-mail está inválido", type: .email))
            exp.fulfill()
        }
        
        validationSpy.simulateError(ValidationFieldModel(message: "O campo E-mail está inválido", type: .email))
        sut.createUser(userRequest: makeRegisterUserRequest(email: "invalid.email", password: "any_password"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_createUser_shouldReturnError_whenUsernameIsEmpty() {
        let fieldValidationDelegateSpy = FieldDescriptionSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, fieldValidationDelegate: fieldValidationDelegateSpy)
        
        let exp = expectation(description: "waiting")
        
        
        fieldValidationDelegateSpy.observe { viewModel in
            XCTAssertEqual(viewModel, ValidationFieldModel(message: "O campo Nome é obrigatório", type: .regular))
            exp.fulfill()
        }
        
        validationSpy.simulateError(ValidationFieldModel(message: "O campo Nome é obrigatório", type: .regular))
        
        sut.createUser(userRequest: makeRegisterUserRequest(username: ""))
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_createUser_shouldReturnError_whenPasswordIsEmpty() {
        let fieldValidationDelegateSpy = FieldDescriptionSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, fieldValidationDelegate: fieldValidationDelegateSpy)
        
        let exp = expectation(description: "waiting")
        
        fieldValidationDelegateSpy.observe { viewModel in
            XCTAssertEqual(viewModel, ValidationFieldModel(message: "O campo Senha é obrigatório", type: .password))
            exp.fulfill()
        }
        
        validationSpy.simulateError(ValidationFieldModel(message: "O campo Senha é obrigatório", type: .password))
        sut.createUser(userRequest: makeRegisterUserRequest(password: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_createUser_shouldReturnError_whenConfirmPasswordIsEmpty() {
        let fieldValidationDelegateSpy = FieldDescriptionSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, fieldValidationDelegate: fieldValidationDelegateSpy)
        
        let exp = expectation(description: "waiting")
        
        
        fieldValidationDelegateSpy.observe { viewModel in
            XCTAssertEqual(viewModel, ValidationFieldModel(message: "O campo Confirmação de senha é obrigatório", type: .passwordConfirm))
            exp.fulfill()
        }
        
        validationSpy.simulateError(ValidationFieldModel(message: "O campo Confirmação de senha é obrigatório", type: .passwordConfirm))
        
        sut.createUser(userRequest: makeRegisterUserRequest(confirmPassword: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_createUser_shouldReturnError_whenPasswordsDoNotMatch() {
        let fieldValidationDelegateSpy = FieldDescriptionSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, fieldValidationDelegate: fieldValidationDelegateSpy)
        
        let exp = expectation(description: "waiting")
        
        fieldValidationDelegateSpy.observe { viewModel in
            XCTAssertEqual(viewModel, ValidationFieldModel(message: "Os campos de senha devem coincidir", type: .passwordConfirm))
            exp.fulfill()
        }
        
        validationSpy.simulateError(ValidationFieldModel(message: "Os campos de senha devem coincidir", type: .passwordConfirm))
        
        sut.createUser(userRequest: makeRegisterUserRequest(password: "123456", confirmPassword: "5445667"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_createUser_shouldReturnError_whenTermsOfServiceNotAccepted() {
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(alertViewSpy: alertViewSpy)
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
    
    func test_createUser_shouldUpdateLoadingState_whenRegisterFails() {
        let userRegisterSpy = CreateAccountUseCaseSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy)
        let exp = expectation(description: "waiting")
        var loadingStates = [Bool]()
        
        sut.loadingHandler = { state in
            loadingStates.append(state.isLoading)
            if loadingStates.count == 2 { exp.fulfill() }
        }
        
        sut.toggleTerms(assined: true)
        sut.createUser(userRequest: makeRegisterUserRequest())
        userRegisterSpy.completeWithFailure(httpError: .badRequest)
        
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(loadingStates, [true, false])
    }
    
    func test_createUser_shouldUpdateLoadingState_whenRegisterSucceeds() {
        let userRegisterSpy = CreateAccountUseCaseSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy)
        let exp = expectation(description: "waiting")
        var loadingStates = [Bool]()
        
        sut.loadingHandler = { state in
            loadingStates.append(state.isLoading)
            if loadingStates.count == 2 { exp.fulfill() }
        }
        
        sut.toggleTerms(assined: true)
        sut.createUser(userRequest: makeRegisterUserRequest())
        userRegisterSpy.completeWithSuccess(reponse: .init(message: "Conta criada com sucesso"))
        
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(loadingStates, [true, false])
    }
}

extension RegisterViewModelTests {
    func makeSut(validationSpy: ValidationSpy = ValidationSpy(),
                 userRegisterSpy: CreateAccountUseCaseSpy = CreateAccountUseCaseSpy(),
                 alertViewSpy: AlertViewSpy = AlertViewSpy(),
                 fieldValidationDelegate: FieldDescriptionSpy = FieldDescriptionSpy(),
                 file: StaticString = #filePath, line: UInt = #line) -> RegisterViewModel
    {
        let sut = RegisterViewModel(validatorComposite: validationSpy, createAccount: userRegisterSpy)
        
        sut.fieldValidationDelegate = fieldValidationDelegate
        sut.alertView = alertViewSpy
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
