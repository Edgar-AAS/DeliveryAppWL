import XCTest
@testable import DeliveryApp

final class LoginViewModelTests: XCTestCase {
    func test_signIn_shouldCallAuthWithCorrectCredentials() {
        let userLoginSpy = AccountLoginSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy)
        let loginCredential = makeLoginCredential()
        sut.signIn(credential: loginCredential)
        XCTAssertEqual(userLoginSpy.loginCredential, loginCredential)
    }

    func test_signIn_shouldReturnError_whenEmailIsEmpty() {
        let fieldValidationDelegateSpy = FieldDescriptionSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, fieldValidationDelegate: fieldValidationDelegateSpy)
        let exp = expectation(description: "waiting")
        
        fieldValidationDelegateSpy.observe { viewModel in
            XCTAssertEqual(viewModel, ValidationFieldModel(message: "O campo E-mail é obrigatório", type: .email))
            exp.fulfill()
        }
        
        validationSpy.simulateError(.init(message: "O campo E-mail é obrigatório", type: .email))
        sut.signIn(credential: makeLoginCredential(email: "", password: ""))
        
        wait(for: [exp], timeout: 1)
    }

    func test_signIn_shouldReturnError_whenEmailIsEmptyAndPasswordIsProvided() {
        let fieldValidationDelegateSpy = FieldDescriptionSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, fieldValidationDelegate: fieldValidationDelegateSpy)
        let exp = expectation(description: "waiting")
        
        fieldValidationDelegateSpy.observe { viewModel in
            XCTAssertEqual(viewModel, ValidationFieldModel(message: "O campo E-mail é obrigatório", type: .email))
            exp.fulfill()
        }

        validationSpy.simulateError(.init(message: "O campo E-mail é obrigatório", type: .email))
        sut.signIn(credential: makeLoginCredential(email: "", password: "password"))
        wait(for: [exp], timeout: 1)
    }

    func test_signIn_shouldReturnError_whenEmailIsInvalidAndPasswordIsEmpty() {
        let fieldValidationDelegateSpy = FieldDescriptionSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, fieldValidationDelegate: fieldValidationDelegateSpy)
        let exp = expectation(description: "waiting")
        
        fieldValidationDelegateSpy.observe { viewModel in
            XCTAssertEqual(viewModel, ValidationFieldModel(message: "O campo E-mail está inválido", type: .email))
            exp.fulfill()
        }
        
        validationSpy.simulateError(ValidationFieldModel(message: "O campo E-mail está inválido", type: .email))

        sut.signIn(credential: makeLoginCredential(email: "invalid.email", password: ""))
        wait(for: [exp], timeout: 1)
    }

    func test_signIn_shouldReturnError_whenEmailIsInvalidAndPasswordIsProvided() {
        let fieldValidationDelegateSpy = FieldDescriptionSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, fieldValidationDelegate: fieldValidationDelegateSpy)
        let exp = expectation(description: "waiting")
        
        fieldValidationDelegateSpy.observe { viewModel in
            XCTAssertEqual(viewModel, ValidationFieldModel(message: "O campo E-mail está inválido", type: .email))
            exp.fulfill()
        }

        validationSpy.simulateError(ValidationFieldModel(message: "O campo E-mail está inválido", type: .email))
        sut.signIn(credential: makeLoginCredential(email: "invalid.email", password: "password"))
        wait(for: [exp], timeout: 1)
    }

    func test_signIn_shouldReturnError_whenPasswordIsEmptyAndEmailIsValid() {
        let fieldValidationDelegateSpy = FieldDescriptionSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, fieldValidationDelegate: fieldValidationDelegateSpy)
        let exp = expectation(description: "waiting")
        
        fieldValidationDelegateSpy.observe { viewModel in
            XCTAssertEqual(viewModel, ValidationFieldModel(message: "O campo Senha é obrigatório", type: .password))
            exp.fulfill()
        }

        validationSpy.simulateError(ValidationFieldModel(message: "O campo Senha é obrigatório", type: .password))
        sut.signIn(credential: makeLoginCredential(email: "valid_email@gmail.com", password: ""))
        wait(for: [exp], timeout: 1)
    }

    func test_signIn_shouldShowAlert_whenLoginFails() {
        let userLoginSpy = AccountLoginSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy, alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Email e/ou senha inválida."))
            exp.fulfill()
        }

        sut.signIn(credential: makeLoginCredential())
        userLoginSpy.completeWithFailure(httpError: .badRequest)
        wait(for: [exp], timeout: 1)
    }

    func test_signIn_shouldShowUnexpectedError_whenNoConnectivity() {
        let userLoginSpy = AccountLoginSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy, alertViewSpy: alertViewSpy)
        let exp = expectation(description: "waiting")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em instantes."))
            exp.fulfill()
        }

        sut.signIn(credential: makeLoginCredential(email: "email@gmail.com", password: "123456"))
        userLoginSpy.completeWithFailure(httpError: .noConnectivity)
        wait(for: [exp], timeout: 1)
    }

    func test_signIn_shouldUpdateLoadingState_whenAuthenticationFails() {
        let userLoginSpy = AccountLoginSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy)
        let exp = expectation(description: "waiting for begin loading")
        let exp2 = expectation(description: "waiting for end loading")
        var loadingStates: [Bool] = []
        
        sut.loadingHandler = { state in
            loadingStates.append(state.isLoading)
            if loadingStates.count == 1 { exp.fulfill() }
            if loadingStates.count == 2 { exp2.fulfill() }
        }

        sut.signIn(credential: makeLoginCredential())
        userLoginSpy.completeWithFailure(httpError: .badRequest)
        
        wait(for: [exp, exp2], timeout: 1)
        XCTAssertEqual(loadingStates, [true, false])
    }

    func test_signIn_shouldUpdateLoadingState_whenAuthenticationSucceeds() {
        let userLoginSpy = AccountLoginSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy)
        let exp = expectation(description: "waiting for begin loading")
        let exp2 = expectation(description: "waiting for end loading")
        var loadingStates: [Bool] = []
        
        sut.loadingHandler = { state in
            loadingStates.append(state.isLoading)
            if loadingStates.count == 1 { exp.fulfill() }
            if loadingStates.count == 2 { exp2.fulfill() }
        }

        sut.signIn(credential: makeLoginCredential())
        userLoginSpy.completeWithSuccess()
        
        wait(for: [exp, exp2], timeout: 1)
        XCTAssertEqual(loadingStates, [true, false])
    }
}

extension LoginViewModelTests {
    func makeSut(validationSpy: ValidationSpy = ValidationSpy(),
                 userLoginSpy: AccountLoginSpy = AccountLoginSpy(),
                 alertViewSpy: AlertViewSpy = AlertViewSpy(),
                 fieldValidationDelegate: FieldDescriptionSpy = FieldDescriptionSpy(),
                 file: StaticString = #filePath, line: UInt = #line) -> LoginViewModel
    {
        let sut = LoginViewModel(userAccountLogin: userLoginSpy,
                               validatorComposite: validationSpy)
        
        sut.fieldValidationDelegate = fieldValidationDelegate
        sut.alertView = alertViewSpy
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
