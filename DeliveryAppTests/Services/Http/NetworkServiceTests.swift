import XCTest
@testable import DeliveryApp

class NetworkServiceTests: XCTestCase {
    func test_requestWithValidURLAndMethod_performsGETRequest() {
        let url = makeUrl()
        let resource = Resource(url: url, method: .get([]))
        testRequestFor(resource: resource) { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("GET", request.httpMethod)
        }
    }
    
    func test_requestWithError_completesWithConnectivityError() {
        let resource = Resource(url: makeUrl(), method: .get([]))
        expectResult(.failure(.noConnectivity), for: resource, when: (data: nil, response: nil, error: URLError(.notConnectedToInternet)))
        expectResult(.failure(.noConnectivity), for: resource, when: (data: nil, response: nil, error: URLError(.networkConnectionLost)))
        expectResult(.failure(.timeout), for: resource, when: (data: nil, response: nil, error: URLError(.timedOut)))
    }
    
    func test_requestWithNon2xxResponse_completesWithCorrespondingHTTPError() {
        let resource = Resource(url: makeUrl(), method: .get([]))
        expectResult(.failure(.badRequest), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expectResult(.failure(.serverError), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))
        expectResult(.failure(.unauthorized), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil))
        expectResult(.failure(.forbidden), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 403), error: nil))
    }
    
    func test_requestWith2xxResponse_completesWithData() {
        let resource = Resource(url: makeUrl(), method: .get([]))
        expectResult(.success(makeValidData()), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 200), error: nil))
    }
    
    func test_requestWith204Response_completesWithNoData() {
        let resource = Resource(url: makeUrl(), method: .get([]))
        expectResult(.success(nil), for: resource, when: (data: nil, response: makeHttpResponse(statusCode: 204), error: nil))
    }
}

extension NetworkServiceTests {
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = HTTPClient(session: session)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func testRequestFor(resource: Resource, action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let exp = expectation(description: "waiting")
        sut.load(resource) { _ in exp.fulfill() }
        var request: URLRequest?
        
        UrlProtocolStub.observerRequest { request = $0 }
        wait(for: [exp], timeout: 1)
        action(request!)
    }
    
    func expectResult(_ expectedResult: Result<Data?, HttpError>, for resource: Resource, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #filePath, line: UInt = #line) {
        let sut = makeSut()
        UrlProtocolStub.simulate(data: stub.data, response: stub.response, error: stub.error)
        let exp = expectation(description: "waiting")
        sut.load(resource) { (receivedResult) in
            switch (expectedResult, receivedResult) {
            case (.failure(let expectedError), .failure(let receivedError)):
                XCTAssertEqual(expectedError, receivedError, file: file, line: line)
            case (.success(let expectedData), .success(let receivedData)):
                XCTAssertEqual(expectedData, receivedData, file: file, line: line)
            default:
                XCTFail("Expected \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        wait(for: [exp], timeout: 1)
    }
}
