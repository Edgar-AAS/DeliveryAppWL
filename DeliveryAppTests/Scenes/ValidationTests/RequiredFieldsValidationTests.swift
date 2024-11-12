import Foundation
import XCTest
@testable import DeliveryApp

class RequiredFieldsValidationTests: XCTestCase {
    func test_validateEmptyField_shouldReturnErrorMessage() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", fieldType: .email)
        let validationFieldModel = sut.validate(data: ["email": ""])
        XCTAssertEqual(validationFieldModel, ValidationFieldModel(message: "O Campo Email é obrigatório", type: .email))
    }
    
    func test_validateFieldLabel_shouldReturnCorrectErrorMessage() {
        let sut = makeSut(fieldName: "password", fieldLabel: "Senha", fieldType: .password)
        let validationFieldModel = sut.validate(data: ["password": ""])
        XCTAssertEqual(validationFieldModel, ValidationFieldModel(message: "O Campo Senha é obrigatório", type: .password))
    }
    
    func test_validatePopulatedField_shouldReturnNil() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", fieldType: .email)
        let validationFieldModel = sut.validate(data: ["email": "any_email@gmail.com"])
        XCTAssertNil(validationFieldModel)
    }
    
    func test_validateNilData_shouldReturnErrorMessage() {
        let sut = makeSut(fieldName: "email", fieldLabel: "Email", fieldType: .email)
        let validationFieldModel = sut.validate(data: nil)
        XCTAssertEqual(validationFieldModel, ValidationFieldModel(message: "O Campo Email é obrigatório", type: .email))
    }
}

extension RequiredFieldsValidationTests {
    func makeSut(fieldName: String, fieldLabel: String, fieldType: FieldType, file: StaticString = #filePath, line: UInt = #line) -> ValidationProtocol {
        let sut = RequiredFieldValidator(fieldName: fieldName, fieldLabel: fieldLabel, fieldType: fieldType)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}
