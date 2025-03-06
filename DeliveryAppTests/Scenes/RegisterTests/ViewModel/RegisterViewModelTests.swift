import XCTest
@testable import DeliveryApp

final class RegisterViewModelTests: XCTestCase {
    func test_createAccount_shouldCallUseCaseWithCorrectData() {
        let alertViewSpy = AlertViewSpy()
        let createAccountSpy = CreateAccountUseCaseSpy()
        let sut = makeSut(userRegisterSpy: createAccountSpy, alertViewSpy: alertViewSpy)
        let accountModel = RegisterAccountRequest(
            name: "any_Name",
            email: "valid_email@gmail.com",
            password: "any_Password"
        )        
        sut.toggleTerms(assined: true)
        sut.createAccount(userRequest: makeRegisterUserRequest())
        XCTAssertEqual(createAccountSpy.userRequest, accountModel)
    }
    
    func test_createAccount_shouldTriggerCreatedAccountCallBack_whenAuthenticationSucceeds() {
        let alertViewSpy = AlertViewSpy()
        let createAccountSpy = CreateAccountUseCaseSpy()
        let sut = makeSut(userRegisterSpy: createAccountSpy, alertViewSpy: alertViewSpy)
        
        let exp = expectation(description: "Waiting for createdAccountCallBack to be called")
        
        sut.createdAccountCallBack = {
            exp.fulfill()
            XCTAssert(true)
        }
        
        sut.toggleTerms(assined: true)
        sut.createAccount(userRequest: makeRegisterUserRequest())
        createAccountSpy.completeWithSuccess()
        wait(for: [exp], timeout: 1)
    }
    
    func test_createAccount_shouldShowEmailInUseError_whenEmailIsAlreadyRegistered() {
        let alertViewSpy = AlertViewSpy()
        let userRegisterSpy = CreateAccountUseCaseSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy, alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro",
                                                   message: "Este Email já esta cadastrado a uma conta."))
            exp.fulfill()
        }
        
        sut.toggleTerms(assined: true)
        sut.createAccount(userRequest: makeRegisterUserRequest())
        userRegisterSpy.completeWithFailure(registerError: .emailInUse)
        wait(for: [exp], timeout: 1)
    }
    
    
    func test_createAccount_shouldShowUnexpectedError_whenUseCaseCompletesWithUnexpectedError() {
        let alertViewSpy = AlertViewSpy()
        let userRegisterSpy = CreateAccountUseCaseSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy, alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro",
                                                   message: "Ocorreu um erro inesperado, tente novamente em instantes."))
            exp.fulfill()
        }
        
        sut.toggleTerms(assined: true)
        sut.createAccount(userRequest: makeRegisterUserRequest())
        userRegisterSpy.completeWithFailure(registerError: .unexpected)
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_createAccount_shouldShowNetworkError_whenNoConnectivity() {
        let alertViewSpy = AlertViewSpy()
        let userRegisterSpy = CreateAccountUseCaseSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy, alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro",
                                                   message: "Você está offline. Por favor, verifique sua conexão de internet."))
            exp.fulfill()
        }
        
        sut.toggleTerms(assined: true)
        sut.createAccount(userRequest: makeRegisterUserRequest())
        userRegisterSpy.completeWithFailure(registerError: .noConnectivity)
        wait(for: [exp], timeout: 1)
    }
    
    func test_createAccount_shouldReturnError_whenEmailIsEmpty() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, alertViewSpy: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel.message, "O campo E-mail é obrigatório")
            exp.fulfill()
        }
        
        validationSpy.simulateError(errorMessage: "O campo E-mail é obrigatório")
        sut.createAccount(userRequest: makeRegisterUserRequest(email: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_createAccount_shouldReturnError_whenEmailIsEmptyAndPasswordIsProvided() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, alertViewSpy: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel.message, "O campo E-mail é obrigatório")
            exp.fulfill()
        }
        
        validationSpy.simulateError(errorMessage: "O campo E-mail é obrigatório")
        
        sut.createAccount(userRequest: makeRegisterUserRequest(email: "", password: "any_password"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_createAccount_shouldReturnError_whenEmailIsInvalidAndPasswordIsEmpty() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, alertViewSpy: alertViewSpy)
        
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel.message, "O campo E-mail está inválido")
            exp.fulfill()
        }
        
        validationSpy.simulateError(errorMessage: "O campo E-mail está inválido")
        sut.createAccount(userRequest: makeRegisterUserRequest(email: "invalid.email", password: ""))
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_createAccount_shouldReturnError_whenEmailIsInvalidAndPasswordIsProvided() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, alertViewSpy: alertViewSpy)
    
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel.message, "O campo E-mail está inválido")
            exp.fulfill()
        }
        
        validationSpy.simulateError(errorMessage: "O campo E-mail está inválido")
        sut.createAccount(userRequest: makeRegisterUserRequest(email: "invalid.email", password: "any_password"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_createAccount_shouldReturnError_whenUsernameIsEmpty() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, alertViewSpy: alertViewSpy)

        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel.message, "O campo Nome é obrigatório")
            exp.fulfill()
        }
        
        validationSpy.simulateError(errorMessage: "O campo Nome é obrigatório")
        sut.createAccount(userRequest: makeRegisterUserRequest(username: ""))
        
        wait(for: [exp], timeout: 1)
    }
    
    func test_createAccount_shouldReturnError_whenPasswordIsEmpty() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, alertViewSpy: alertViewSpy)

        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel.message, "O campo Senha é obrigatório")
            exp.fulfill()
        }
        
        validationSpy.simulateError(errorMessage: "O campo Senha é obrigatório")
        sut.createAccount(userRequest: makeRegisterUserRequest(password: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_createAccount_shouldReturnError_whenConfirmPasswordIsEmpty() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, alertViewSpy: alertViewSpy)

        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel.message, "O campo Confirmação de senha é obrigatório")
            exp.fulfill()
        }
        
        validationSpy.simulateError(errorMessage: "O campo Confirmação de senha é obrigatório")
        sut.createAccount(userRequest: makeRegisterUserRequest(confirmPassword: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_createAccount_shouldReturnError_whenPasswordsDoNotMatch() {
        let alertViewSpy = AlertViewSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, alertViewSpy: alertViewSpy)

        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel.message, "Os campos de senha devem coincidir")
            exp.fulfill()
        }
        
        validationSpy.simulateError(errorMessage: "Os campos de senha devem coincidir")
        sut.createAccount(userRequest: makeRegisterUserRequest(password: "123456", confirmPassword: "5445667"))
        wait(for: [exp], timeout: 1)
    }
    
    func test_createAccount_shouldReturnError_whenTermsOfServiceNotAccepted() {
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
        
        sut.createAccount(userRequest: makeRegisterUserRequest())
        wait(for: [exp], timeout: 1)
    }
    
    func test_createAccount_shouldUpdateLoadingState_whenRegisterFails() {
        let userRegisterSpy = CreateAccountUseCaseSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy)
        let exp = expectation(description: "waiting")
        var loadingStates = [Bool]()
        
        sut.loadingHandler = { state in
            loadingStates.append(state)
            if loadingStates.count == 2 { exp.fulfill() }
        }
        
        sut.toggleTerms(assined: true)
        sut.createAccount(userRequest: makeRegisterUserRequest())
        userRegisterSpy.completeWithFailure(registerError: .unexpected)
        
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(loadingStates, [true, false])
    }
    
    func test_createAccount_shouldUpdateLoadingState_whenRegisterSucceeds() {
        let userRegisterSpy = CreateAccountUseCaseSpy()
        let sut = makeSut(userRegisterSpy: userRegisterSpy)
        let exp = expectation(description: "waiting")
        var loadingStates = [Bool]()
        
        sut.loadingHandler = { state in
            loadingStates.append(state)
            if loadingStates.count == 2 { exp.fulfill() }
        }
        
        sut.toggleTerms(assined: true)
        sut.createAccount(userRequest: makeRegisterUserRequest())
        
        userRegisterSpy.completeWithSuccess()
        
        wait(for: [exp], timeout: 1)
        XCTAssertEqual(loadingStates, [true, false])
    }
}

extension RegisterViewModelTests {
    func makeSut(validationSpy: ValidationSpy = ValidationSpy(),
                 userRegisterSpy: CreateAccountUseCaseSpy = CreateAccountUseCaseSpy(),
                 alertViewSpy: AlertViewSpy = AlertViewSpy(),
                 file: StaticString = #filePath, line: UInt = #line) -> RegisterViewModel
    {
        let sut = RegisterViewModel(validatorComposite: validationSpy, createAccount: userRegisterSpy)
        sut.alertView = alertViewSpy
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
