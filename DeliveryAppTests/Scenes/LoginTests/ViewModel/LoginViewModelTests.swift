import XCTest
@testable import DeliveryApp

final class LoginViewModelTests: XCTestCase {
    func test_login_shouldAuthenticateWithCorrectCredentials() {
        let userLoginSpy = AccountLoginSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy)
        let loginCredential = makeLoginCredential()
        sut.login(credential: loginCredential)
        XCTAssertEqual(userLoginSpy.loginCredential, loginCredential)
    }
    
    func test_login_shouldTriggerOnLoginSuccess_whenAuthenticationSucceeds() {
        let userLoginSpy = AccountLoginSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy)
        sut.login(credential: makeLoginCredential())
        
        let exp = expectation(description: "Waiting for onLoginSuccess to be called")
        sut.onSuccess = {
            exp.fulfill()
            XCTAssert(true)
        }
        
        userLoginSpy.completeWithSuccess()
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_shouldClearFieldErrors_whenValidationSucceeds() {
        let userLoginSpy = AccountLoginSpy()
        let fieldDelegateSpy = FieldDescriptionSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy, fieldValidationDelegate: fieldDelegateSpy)
        sut.login(credential: makeLoginCredential())
        XCTAssertEqual(fieldDelegateSpy.clearErrorCallsCount, 1)
    }
    
    func test_login_shouldShowInvalidCredentialsError_whenAuthenticationFails() {
        let userLoginSpy = AccountLoginSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy, alertViewSpy: alertViewSpy)
        let exp = expectation(description: "Waiting for alert view to show error")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Error", message: "Email e/ou senha inválidos."))
            exp.fulfill()
        }
        
        sut.login(credential: makeLoginCredential())
        userLoginSpy.completeWithFailure(loginError: .invalidCredentials)
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_shouldShowNoConnectivityError_whenOffline() {
        let userLoginSpy = AccountLoginSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy, alertViewSpy: alertViewSpy)
        let exp = expectation(description: "Waiting for alert view to show no connectivity error")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Error",
                                                     message: "Você está offline. Por favor, verifique sua conexão de internet."))
            exp.fulfill()
        }
        
        sut.login(credential: makeLoginCredential(email: "email@gmail.com", password: "123456"))
        userLoginSpy.completeWithFailure(loginError: .noConnectivity)
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_shouldShowUnexpectedError_whenUnexpectedFailureOccurs() {
        let userLoginSpy = AccountLoginSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy, alertViewSpy: alertViewSpy)
        let exp = expectation(description: "Waiting for alert view to show unexpected error")
        
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Error", message: "Ocorreu um erro inesperado. Tente novamente."))
            exp.fulfill()
        }
        
        sut.login(credential: makeLoginCredential(email: "email@gmail.com", password: "12345678@asdsB"))
        userLoginSpy.completeWithFailure(loginError: .unexpected)
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_shouldReturnError_whenEmailIsEmpty() {
        let fieldValidationDelegateSpy = FieldDescriptionSpy()
        let validationSpy = ValidationSpy()
        let sut = makeSut(validationSpy: validationSpy, fieldValidationDelegate: fieldValidationDelegateSpy)
        let exp = expectation(description: "Waiting for field validation error")
        
        fieldValidationDelegateSpy.observe { viewModel in
            XCTAssertEqual(viewModel, ValidationFieldModel(fieldType: "email", message: "O campo E-mail é obrigatório"))
            exp.fulfill()
        }
        
        validationSpy.simulateError(ValidationFieldModel(fieldType: "email", message: "O campo E-mail é obrigatório"))
        sut.login(credential: makeLoginCredential(email: "", password: ""))
        wait(for: [exp], timeout: 1)
    }
    
    func test_login_shouldUpdateLoadingState_whenAuthenticationFails() {
        let userLoginSpy = AccountLoginSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy)
        let expStart = expectation(description: "Waiting for loading to start")
        let expEnd = expectation(description: "Waiting for loading to end")
        var loadingStates: [Bool] = []
        
        sut.loadingHandler = { state in
            loadingStates.append(state.isLoading)
            if loadingStates.count == 1 { expStart.fulfill() }
            if loadingStates.count == 2 { expEnd.fulfill() }
        }
        
        sut.login(credential: makeLoginCredential())
        userLoginSpy.completeWithFailure(loginError: .unexpected)
        
        wait(for: [expStart, expEnd], timeout: 1)
        XCTAssertEqual(loadingStates, [true, false])
    }
    
    func test_login_shouldUpdateLoadingState_whenAuthenticationSucceeds() {
        let userLoginSpy = AccountLoginSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy)
        let expStart = expectation(description: "Waiting for loading to start")
        let expEnd = expectation(description: "Waiting for loading to end")
        var loadingStates: [Bool] = []
        
        sut.loadingHandler = { state in
            loadingStates.append(state.isLoading)
            if loadingStates.count == 1 { expStart.fulfill() }
            if loadingStates.count == 2 { expEnd.fulfill() }
        }
        
        sut.login(credential: makeLoginCredential())
        userLoginSpy.completeWithSuccess()
        
        wait(for: [expStart, expEnd], timeout: 1)
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
