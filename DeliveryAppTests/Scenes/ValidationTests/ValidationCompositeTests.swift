import Foundation
import XCTest
@testable import DeliveryApp

class ValidationCompositeTests: XCTestCase {
    func test_validate_should_return_error_if_validation_fails() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        validationSpy.simulateError(.init(message: "Error 1"))
        
        let errorModel = sut.validate(data: ["name": "any_name"])
        XCTAssertEqual(errorModel, (.init(message: "Error 1")))
    }
    
    func test_validate_should_return_correct_error_message() {
        let validationSpy2 = ValidationSpy()
        let sut = makeSut(validations: [ValidationSpy(), validationSpy2])
        
        validationSpy2.simulateError(.init(message: "Error 2"))
        
        let errorModel = sut.validate(data: ["name": "any_name"])
        XCTAssertEqual(errorModel, .init(message: "Error 2"))
    }
    
    func test_validate_should_return_the_first_error_message() {
        let validationSpy2 = ValidationSpy()
        let validationSpy3 = ValidationSpy()
        let sut = makeSut(validations: [ValidationSpy(), validationSpy2, validationSpy3])
        validationSpy2.simulateError(.init(message: "Error 2"))
        validationSpy3.simulateError(.init(message: "Error 3"))
        let errorModel = sut.validate(data: ["name": "any_name"])
        XCTAssertEqual(errorModel, .init(message: "Error 2"))
    }
    
    func test_validate_should_return_nil_if_validation_succeeds() {
        let sut = makeSut(validations: [ValidationSpy(), ValidationSpy()])
        let errorMessage = sut.validate(data: ["name": "any_name"])
        XCTAssertNil(errorMessage)
    }
        
    func test_validate_should_calls_validation_with_correct_data() {
        let validationSpy = ValidationSpy()
        let sut = makeSut(validations: [validationSpy])
        let data: [String: Any] = ["name": "any_name"]
        _ = sut.validate(data: ["name": "any_name"])
        XCTAssertTrue(NSDictionary(dictionary: validationSpy.data!).isEqual(to: data))
    }
}

extension ValidationCompositeTests {
    func makeSut(validations: [ValidationSpy], file: StaticString = #filePath, line: UInt = #line) -> ValidationProtocol {
        let sut = ValidationComposite(validations: validations)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
}

