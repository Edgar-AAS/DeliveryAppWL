import XCTest
@testable import DeliveryApp

final class CreateAccountTests: XCTestCase {
    func test_createAccount_withSuccess() {
        let httpClientMock = HTTPClientMock()
        let sut = makeSut(httpClientMock: httpClientMock)
        
        let expectedRequest = makeAccountModel()
        
        sut.registerAccountResource = { request in
            XCTAssertEqual(request.name, expectedRequest.name)
            XCTAssertEqual(request.email, expectedRequest.email)
            XCTAssertEqual(request.password, expectedRequest.password)
            return ResourceModel(url: makeUrl(), method: .post(request.toData()))
        }
                    
        let exp = expectation(description: "completion is called")
        sut.register(with: expectedRequest) { result in
            if case .success = result {
                exp.fulfill()
            } else {
                XCTFail("Expected success but got \(result) instead.")
            }
        }
        
        httpClientMock.success(makeValidData())
        wait(for: [exp], timeout: 1.0)
    }
    
    func test_createAccount_should_complete_with_emailInUse_when_http_complete_with_conflict() {
        let httpClientMock = HTTPClientMock()
        let sut = makeSut(httpClientMock: httpClientMock)
        
        let exp = expectation(description: "waiting")
        sut.register(with: makeAccountModel()) { result in
            switch result {
                case .success(_):  XCTFail("Expected failure but got \(result) instead.")
                case .failure(let registerError):
                XCTAssertEqual(registerError, .emailInUse)
                exp.fulfill()
            }
        }
        
        httpClientMock.failure(.conflict)
        wait(for: [exp], timeout: 1.0)
    }
    
    
    func test_createAccount_should_complete_with_noConnectivity_when_http_comple_with_noConnectivity() {
        let httpClientMock = HTTPClientMock()
        let sut = makeSut(httpClientMock: httpClientMock)
        let exp = expectation(description: "waiting")
        
        sut.register(with: makeAccountModel()) { result in
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
    
    func test_createAccount_should_complete_with_unexpected_when_http_complete_with_other_http_errors() {
        let httpClientMock = HTTPClientMock()
        let sut = makeSut(httpClientMock: httpClientMock)
        let exp = expectation(description: "waiting")
        
        sut.register(with: makeAccountModel()) { result in
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

extension CreateAccountTests {
    func makeSut(httpClientMock: HTTPClientProtocol = HTTPClientMock()) -> RegisterAccount {
        let sut = RegisterAccount(httpClient: httpClientMock)
        sut.registerAccountResource = { accountModel in
            return ResourceModel(
                url: makeUrl(),
                method: .post(accountModel.toData())
            )
        }
        return sut
    }
}

