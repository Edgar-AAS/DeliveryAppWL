import XCTest
@testable import DeliveryApp

class EmailFieldValidatorTests: XCTestCase {
    func test_validate_should_return_error_if_invalid_email_is_provided() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidatorSpy: emailValidatorSpy)
        
        emailValidatorSpy.simulateError()
        
        let validationFieldModel = sut.validate(data: ["email": "invalid_email@gmail.com"])
        XCTAssertEqual(validationFieldModel,  ValidationFieldModel(fieldType: "email", message: "O campo Email está inválido"))
    }
    
    func test_validate_should_return_error_with_correct_fieldLabel() {
        let emailValidatorSpy = EmailValidatorSpy()
        let sut = makeSut(fieldName: "email", fieldLabel: "Email2", emailValidatorSpy: emailValidatorSpy)
        
        emailValidatorSpy.simulateError()
        
        let validationFieldModel = sut.validate(data: ["email": "invalid_email@gmail.com"])
        XCTAssertEqual(validationFieldModel,  ValidationFieldModel(fieldType: "email", message: "O campo Email2 está inválido"))
    }
    
    func test_validate_should_return_nil_if_valid_email_is_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidatorSpy: EmailValidatorSpy())
        let validationFieldModel = sut.validate(data: ["email": "valid_email@gmail.com"])
        XCTAssertNil(validationFieldModel)
    }
    
    func test_validate_should_return_nil_if_no_data_is_provided() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", emailValidatorSpy: EmailValidatorSpy())
        let validationFieldModel = sut.validate(data: nil)
        XCTAssertEqual(validationFieldModel,  ValidationFieldModel(fieldType: "email", message: "O campo Email está inválido"))
    }
}

extension EmailFieldValidatorTests {
    func makeSut(fieldName: String, fieldLabel: String, emailValidatorSpy: EmailValidatorSpy, file: StaticString = #filePath, line: UInt = #line) -> ValidationProtocol {
        let sut = EmailFieldValidator(fieldName: fieldName, fieldLabel: fieldLabel, emailValidator: emailValidatorSpy)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
