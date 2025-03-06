import Foundation
import XCTest
@testable import DeliveryApp

final class RequiredFieldsValidationTests: XCTestCase {
    func test_validateEmptyField_shouldReturnErrorMessage() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", fieldType: "email")
        let validationMessage = sut.validate(data: ["email": ""])
        XCTAssertEqual(validationMessage, "O campo Email é obrigatório.")
    }
    
    func test_validateFieldLabel_shouldReturnCorrectErrorMessage() {
        let sut = makeSut(fieldName: "password", fieldLabel: "Senha", fieldType: "password")
        let validationMessage = sut.validate(data: ["password": ""])
        XCTAssertEqual(validationMessage, "O campo Senha é obrigatório.")
    }
    
    func test_validatePopulatedField_shouldReturnNil() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", fieldType: "email")
        let validatioMessage = sut.validate(data: ["email": "any_email@gmail.com"])
        XCTAssertNil(validatioMessage)
    }
    
    func test_validateNilData_shouldReturnErrorMessage() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", fieldType: "email")
        let validationMessage = sut.validate(data: nil)
        XCTAssertEqual(validationMessage, "O campo Email é obrigatório.")
    }
}

extension RequiredFieldsValidationTests {
    func makeSut(fieldName: String, fieldLabel: String, fieldType: String, file: StaticString = #filePath, line: UInt = #line) -> Validation {
        let sut = RequiredFieldValidation(fieldName: fieldName, fieldLabel: fieldLabel)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
