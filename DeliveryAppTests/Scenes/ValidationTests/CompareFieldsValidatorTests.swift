import Foundation
import XCTest
@testable import DeliveryApp

class CompareFieldsValidatorTests: XCTestCase {
    func test_validate_should_return_error_if_comparation_fails() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Senha")
        let validationFieldModel = sut.validate(data: ["password": "123", "passwordConfirmation": "1234"])
        XCTAssertEqual(validationFieldModel, ValidationFieldModel(message: "O campo Senha está inválido"))
    }
    
    func test_validate_should_return_error_if_correct_fieldLabel() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Confirmar Senha")
        let validationFieldModel = sut.validate(data: ["password": "123", "passwordConfirmation": "1234"])
        XCTAssertEqual(validationFieldModel, ValidationFieldModel(message: "O campo Confirmar Senha está inválido"))
    }
        
    func test_validate_should_return_nil_if_comparation_succeeds() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Any")
        let validationFieldModel = sut.validate(data: ["password": "correctPassword", "passwordConfirmation": "correctPassword"])
        XCTAssertNil(validationFieldModel)
    }
    
    func test_validate_should_return_error_message_if_data_is_not_provided() {
        let sut = makeSut(fieldName: "password", fieldNameToCompare: "passwordConfirmation", fieldLabel: "Senha")
        let validationFieldModel = sut.validate(data: nil)
        XCTAssertEqual(validationFieldModel, ValidationFieldModel(message: "O campo Senha está inválido"))
    }
}

extension CompareFieldsValidatorTests {
    func makeSut(fieldName: String, fieldNameToCompare: String, fieldLabel: String, file: StaticString = #filePath, line: UInt = #line) -> CompareFieldsValidator {
        let sut = CompareFieldsValidator(fieldName: fieldName, fieldLabel: fieldLabel, fieldNameToCompare: fieldNameToCompare)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
