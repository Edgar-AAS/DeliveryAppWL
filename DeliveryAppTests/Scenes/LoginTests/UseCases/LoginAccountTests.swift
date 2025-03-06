import Foundation
import XCTest
@testable import DeliveryApp

final class LoginAccountTests: XCTestCase {
    func test_loginAccount_withSuccess() {
        let httpClientMock = HTTPClientMock()
        let sut = makeSut(httpClientMock: httpClientMock)
        
        let expectedRequest = makeLoginCredential()
        
        sut.httpResource = { request in
            XCTAssertEqual(request.email, expectedRequest.email)
            XCTAssertEqual(request.password, expectedRequest.password)
            return ResourceModel(url: makeUrl(), method: .post(request.toData()))
        }
        
        let exp = expectation(description: "waiting for completion")
        
        sut.login(with: expectedRequest) { result in
            if case .success = result {
                exp.fulfill()
            } else {
                XCTFail("Expected success but got \(result) instead.")
            }
        }
        
        httpClientMock.success(makeLoginAccountResponse())
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_login_should_complete_with_invalidCredentials_when_http_complete_with_unauthorized() {
        let httpClientMock = HTTPClientMock()
        let sut = makeSut(httpClientMock: httpClientMock)
        
        let exp = expectation(description: "waiting for completion")
        
        sut.login(with: makeLoginCredential()) { result in
            switch result {
                case .success(_):  XCTFail("Expected failure but got \(result) instead.")
                case .failure(let loginError):
                XCTAssertEqual(loginError, .invalidCredentials)
                exp.fulfill()
            }
        }
        
        httpClientMock.failure(.unauthorized)
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_login_should_complete_with_noConnectivity_when_http_comple_with_noConnectivity() {
        let httpClientMock = HTTPClientMock()
        let sut = makeSut(httpClientMock: httpClientMock)
        let exp = expectation(description: "waiting")
        
        sut.login(with: makeLoginCredential()) { result in
            switch result {
                case .success(_): XCTFail("Expected success but got \(result) instead.")
                case .failure(let registerError):
                XCTAssertEqual(registerError, .noConnectivity)
                exp.fulfill()
            }
        }
        
        httpClientMock.failure(.noConnectivity)
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_login_should_complete_with_unexpected_when_http_complete_with_other_http_errors() {
        let httpClientMock = HTTPClientMock()
        let sut = makeSut(httpClientMock: httpClientMock)
        let exp = expectation(description: "waiting")
        
        sut.login(with: makeLoginCredential()) { result in
            switch result {
                case .success(_): XCTFail("Expected success but got \(result) instead.")
                case .failure(let registerError):
                XCTAssertEqual(registerError, .unexpected)
                exp.fulfill()
            }
        }
        
        httpClientMock.failure(.badRequest)
        wait(for: [exp], timeout: 1.0)
    }
}

extension LoginAccountTests {
    func makeSut(httpClientMock: HTTPClientProtocol = HTTPClientMock()) -> LoginAccount {
        let sut = LoginAccount(httpClient: httpClientMock, keychainService: KeychainServiceDummy())
        sut.httpResource = { _ in
            return ResourceModel(
                url: makeUrl(),
                method: .post(makeValidData()))
        }
        return sut
    }
}
