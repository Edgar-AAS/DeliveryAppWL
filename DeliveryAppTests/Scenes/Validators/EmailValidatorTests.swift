import XCTest
@testable import DeliveryApp

final class EmailValidatorTests: XCTestCase {
    func test_invalid_emails() {
            let sut = makeSut()
            XCTAssertFalse(sut.isValid("rr"))
            XCTAssertFalse(sut.isValid("rr@"))
            XCTAssertFalse(sut.isValid("rr@rr"))
            XCTAssertFalse(sut.isValid("rr@rr."))
            XCTAssertFalse(sut.isValid("@rr.com"))
        }
        
        func test_valid_emails() {
            let sut = makeSut()
            XCTAssertTrue(sut.isValid("test@gmail.com"))
            XCTAssertTrue(sut.isValid("test@hotmail.com"))
            XCTAssertTrue(sut.isValid("test@outlook.com"))
            XCTAssertTrue(sut.isValid("test@live.de"))
            XCTAssertTrue(sut.isValid("test_test@gmail.com"))
        }
}

extension EmailValidatorTests {
    func makeSut() -> EmailValidator {
        return EmailValidator()
    }
}
