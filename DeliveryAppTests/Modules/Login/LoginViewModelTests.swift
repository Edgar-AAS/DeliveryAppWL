import XCTest
@testable import DeliveryApp

final class LoginViewModelTests: XCTestCase {
    func test_signIn_callsAuthWithCorrectAuthenticationModel() {
        let userLoginSpy = AccountLoginSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy)
        let loginCredential = makeLoginCredential()
        sut.signIn(credential: loginCredential)
        XCTAssertEqual(userLoginSpy.loginCredential, loginCredential)
    }

    func test_signIn_returnsError_whenEmailIsEmpty() {
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo E-mail é obrigatório", type: .email))
            exp.fulfill()
        }

        sut.signIn(credential: makeLoginCredential(email: "", password: ""))
        wait(for: [exp], timeout: 1)
    }

    func test_signIn_returnsError_whenEmailIsEmptyAndPasswordIsProvided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo E-mail é obrigatório", type: .email))
            exp.fulfill()
        }

        sut.signIn(credential: makeLoginCredential(email: "", password: "password"))
        wait(for: [exp], timeout: 1)
    }

    func test_signIn_returnsError_whenEmailIsInvalidAndPasswordIsEmpty() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo E-mail está inválido", type: .email))
            exp.fulfill()
        }

        emailValidatorSpy.completeWithFailure()
        sut.signIn(credential: makeLoginCredential(email: "invalid.email", password: ""))
        wait(for: [exp], timeout: 1)
    }

    func test_signIn_returnsError_whenEmailIsInvalidAndPasswordIsProvided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo E-mail está inválido", type: .email))
            exp.fulfill()
        }

        emailValidatorSpy.completeWithFailure()
        sut.signIn(credential: makeLoginCredential(email: "invalid.email", password: "password"))
        wait(for: [exp], timeout: 1)
    }

    func test_signIn_returnsError_whenPasswordIsEmptyAndEmailIsValid() {
        let emailValidatorSpy = EmailValidatorSpy()
        let fieldDescriptionSpy = FieldDescriptionSpy()
        let sut = makeSut(emailValidatorSpy: emailValidatorSpy, fieldDescriptionSpy: fieldDescriptionSpy)

        let exp = expectation(description: "waiting")
        fieldDescriptionSpy.observe { viewModel in
            XCTAssertEqual(viewModel, FieldValidationViewModel(message: "O campo Senha é obrigatório", type: .password))
            exp.fulfill()
        }

        emailValidatorSpy.completeWithValidEmail()
        sut.signIn(credential: makeLoginCredential(email: "valid_email@gmail.com", password: ""))
        wait(for: [exp], timeout: 1)
    }

    func test_signIn_shows_validation_error_when_login_fails() {
        let userLoginSpy = AccountLoginSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy, alertViewSpy: alertViewSpy)

        let authenticationModel = makeLoginCredential()

        sut.signIn(credential: authenticationModel)

        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Falha na validação", message: "Email e/ou senha inválida."))
            exp.fulfill()
        }

        userLoginSpy.completeWithFailure(httpError: .badRequest)
        wait(for: [exp], timeout: 1)
    }

    func test_signIn_showsUnexpectedErrorMessage_on() {
        let userLoginSpy = AccountLoginSpy()
        let alertViewSpy = AlertViewSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy, alertViewSpy: alertViewSpy)

        let authenticationModel = makeLoginCredential(email: "email@gmail.com", password: "123456")

        sut.signIn(credential: authenticationModel)

        let exp = expectation(description: "waiting")
        alertViewSpy.observe { viewModel in
            XCTAssertEqual(viewModel, AlertViewModel(title: "Erro", message: "Algo inesperado aconteceu, tente novamente em instantes."))
            exp.fulfill()
        }

        userLoginSpy.completeWithFailure(httpError: .noConnectivity)
        wait(for: [exp], timeout: 1)
    }

    func test_loadingHandler_startsWithTrueAndSwitchesToFalse_whenAuthenticationFails() {
        let userLoginSpy = AccountLoginSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy)

        let exp = expectation(description: "waiting")
        sut.loadingHandler = { state in
            XCTAssertTrue(state.isLoading)
            exp.fulfill()
        }

        sut.signIn(credential: makeLoginCredential())

        let exp2 = expectation(description: "waiting")
        sut.loadingHandler = { state in
            XCTAssertFalse(state.isLoading)
            exp2.fulfill()
        }

        userLoginSpy.completeWithFailure(httpError: .badRequest)

        wait(for: [exp, exp2], timeout: 1)
    }

    func test_loadingHandler_startsWithTrueAndSwitchesToFalse_whenAuthenticationSucceeds() {
        let userLoginSpy = AccountLoginSpy()
        let sut = makeSut(userLoginSpy: userLoginSpy)

        let exp = expectation(description: "waiting")
        sut.loadingHandler = { state in
            XCTAssertTrue(state.isLoading)
            exp.fulfill()
        }

        sut.signIn(credential: makeLoginCredential())

        let exp2 = expectation(description: "waiting")
        sut.loadingHandler = { state in
            XCTAssertFalse(state.isLoading)
            exp2.fulfill()
        }

        userLoginSpy.completeWithSuccess()
        wait(for: [exp, exp2], timeout: 1)
    }
}


extension LoginViewModelTests {
    func makeSut(emailValidatorSpy: EmailValidatorSpy = EmailValidatorSpy(),
                 userLoginSpy: AccountLoginSpy = AccountLoginSpy(),
                 alertViewSpy: AlertViewSpy = AlertViewSpy(),
                 fieldDescriptionSpy: FieldDescriptionSpy = FieldDescriptionSpy(),
                 file: StaticString = #filePath, line: UInt = #line) -> LoginViewModel
    {
        let sut = LoginViewModel(userAccountLogin: userLoginSpy,
                                 emailValidation: emailValidatorSpy)
        
        sut.fieldValidationDelegate = fieldDescriptionSpy
        sut.alertView = alertViewSpy
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
