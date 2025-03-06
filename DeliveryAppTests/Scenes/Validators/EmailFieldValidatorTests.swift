import XCTest
@testable import DeliveryApp

final class EmailFieldValidatorTests: XCTestCase {
    func test_validate_should_return_error_if_invalid_email_is_provided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidatorSpy: emailValidatorSpy)
        emailValidatorSpy.simuleInvalidEmail()
        let validationMessage = sut.validate(data: ["email": "invalid_email@gmail.com"])
        XCTAssertEqual(validationMessage, "O campo Email é inválido.")
    }
    
    func test_validate_should_return_nil_if_no_data_is_provided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidatorSpy: emailValidatorSpy)
        emailValidatorSpy.simuleInvalidEmail()
        let validationMessage = sut.validate(data: nil)
        XCTAssertEqual(validationMessage, "O campo Email é inválido.")
    }
    
    func test_validate_should_return_nil_if_valid_email_is_provided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidatorSpy: emailValidatorSpy)
        emailValidatorSpy.simuleValidEmail()
        let validationMessage = sut.validate(data: ["email": "valid_email@gmail.com"])
        XCTAssertNil(validationMessage)
    }
}

extension EmailFieldValidatorTests {
    func makeSut(fieldName: String,
                 fieldLabel: String,
                 emailValidatorSpy: EmailValidatorSpy = EmailValidatorSpy(),
                 file: StaticString = #filePath,
                 line: UInt = #line) -> Validation {
        
        let sut = EmailValidation(fieldName: fieldName, fieldLabel: fieldLabel, emailValidator: emailValidatorSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
