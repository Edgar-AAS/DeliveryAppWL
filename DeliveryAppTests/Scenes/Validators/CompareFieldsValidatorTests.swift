import Foundation
import XCTest
@testable import DeliveryApp

final class CompareFieldsValidatorTests: XCTestCase {
    func test_validate_should_return_error_if_comparation_fails() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")
        let validationMessage = sut.validate(data: ["password": "123", "passwordConfirmation": "1234"])
        XCTAssertEqual(validationMessage, "O campo Confirmar Senha é inválido.")
    }
    
    func test_validate_should_return_nil_if_comparation_succeeds() {
        let sut = makeSut(fieldName: "passwor", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Senha")
        let validationMessage = sut.validate(data: ["password": "correctPassword", "passwordConfirmation": "correctPassword"])
        XCTAssertNil(validationMessage)
    }
    
    func test_validate_should_return_error_message_if_data_is_not_provided() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Senha")
        let validationMessage = sut.validate(data: nil)
        XCTAssertEqual(validationMessage, "O campo Senha é inválido.")
    }
}

extension CompareFieldsValidatorTests {
    func makeSut(fieldName: String, fieldNameToCompare: String, fieldLabel: String, file: StaticString = #filePath, line: UInt = #line) -> CompareFieldsValidation {
        let sut = CompareFieldsValidation(fieldName: fieldName, fieldLabel: fieldLabel, fieldNameToCompare: fieldNameToCompare)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
