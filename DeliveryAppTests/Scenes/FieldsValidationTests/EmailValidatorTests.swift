import XCTest
@testable import DeliveryApp

class EmailValidatorTests: XCTestCase {
    func test_invalid_emails() {
        let sut = makeSut()
        XCTAssertFalse(sut.isValid(email: "test@"))
        XCTAssertFalse(sut.isValid(email: "testExample.com"))
        XCTAssertFalse(sut.isValid(email: "@example.com"))
        XCTAssertFalse(sut.isValid(email: "user @example.com"))
        XCTAssertFalse(sut.isValid(email: "user!@example.com"))
        XCTAssertFalse(sut.isValid(email: "user!@"))
        XCTAssertFalse(sut.isValid(email: ""))
        XCTAssertFalse(sut.isValid(email: "user@domain..com"))
        XCTAssertFalse(sut.isValid(email: ".user@domain.com"))
        XCTAssertFalse(sut.isValid(email: "-user@domain.com-"))
        XCTAssertFalse(sut.isValid(email: ".user@domain.com."))
        XCTAssertFalse(sut.isValid(email: "user@domain.com."))
        XCTAssertFalse(sut.isValid(email: "user@.domain.com"))
        XCTAssertFalse(sut.isValid(email: "user@domain,com"))
    }
    
    func test_valid_emails() {
        let sut = makeSut()
        XCTAssertTrue(sut.isValid(email: "edgar@gmail.com"))
        XCTAssertTrue(sut.isValid(email: "edgar@live.de"))
        XCTAssertTrue(sut.isValid(email: "first.last@example.com"))
        XCTAssertTrue(sut.isValid(email: "user+alias@domain.com"))
        XCTAssertTrue(sut.isValid(email: "user%email@sub.domain.org"))
        XCTAssertTrue(sut.isValid(email: "user_name@domain.io"))
        XCTAssertTrue(sut.isValid(email: "12345@domain.co"))
        XCTAssertTrue(sut.isValid(email: "user@sub-domain.example.net"))
        XCTAssertTrue(sut.isValid(email: "user@domain.co.uk"))
    }
}

extension EmailValidatorTests {
    func makeSut() -> EmailValidator {
        return EmailValidator()
    }
}

