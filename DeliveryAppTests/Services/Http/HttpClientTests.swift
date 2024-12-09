import XCTest
@testable import DeliveryApp

class HttpClientTests: XCTestCase {
    // MARK: - GET Tests
    func test_getRequest_createsCorrectGETRequest() {
        let url = makeUrl()
        let resource = ResourceModel(url: url, method: .get([]))
        testRequestFor(resource: resource) { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("GET", request.httpMethod)
        }
    }
    
    func test_getRequest_includesCorrectHeadersAndNoBodyStream() {
        let resource = ResourceModel(url: makeUrl(), method: .get([]), headers: ["Content-Type": "application/json"])
        testRequestFor(resource: resource) { request in
            XCTAssertEqual(request.allHTTPHeaderFields, resource.headers)
            XCTAssertNil(request.httpBodyStream)
        }
    }
    
    func test_getRequest_completesWithNoData_whenResponseStatus204() {
        let resource = ResourceModel(url: makeUrl(), method: .get([]))
        expectResult(.success(nil), for: resource, when: (data: nil, response: makeHttpResponse(statusCode: 204), error: nil))
    }
    
    func test_getRequest_completesWithData_whenResponseStatus200() {
        let resource = ResourceModel(url: makeUrl(), method: .get([]))
        expectResult(.success(makeValidData()), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 200), error: nil))
    }
    
    func test_getRequest_handlesHTTPErrorResponses() {
        let resource = ResourceModel(url: makeUrl(), method: .get([]))
        
        expectResult(.failure(.badRequest), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expectResult(.failure(.badRequest), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expectResult(.failure(.unauthorized), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil))
        expectResult(.failure(.forbidden), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 403), error: nil))
        expectResult(.failure(.notFound), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 404), error: nil))
        expectResult(.failure(.serverError), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))
        expectResult(.failure(.serverError), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 503), error: nil))
        
        expectResult(.failure(.unknown), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 600), error: makeError()))
        
        expectResult(.failure(.unknown), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 600), error: makeError()))
        
        expectResult(.failure(.unknown), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 600), error: nil))
        
        expectResult(.failure(.invalidResponse), for: resource, when: (data: nil, response: nil, error: nil))
        expectResult(.failure(.invalidResponse), for: resource, when: (data: makeValidData(), response: nil, error: nil))
        expectResult(.failure(.noConnectivity), for: resource, when: (data: nil, response: nil, error: URLError(.notConnectedToInternet)))
        expectResult(.failure(.timeout), for: resource, when: (data: nil, response: nil, error: URLError(.timedOut)))
    }
    
    // MARK: - POST Tests
    func test_postRequest_createsCorrectPOSTRequest() {
        let url = makeUrl()
        let resource = ResourceModel(url: url, method: .post(makeValidData()))
        testRequestFor(resource: resource) { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("POST", request.httpMethod)
        }
    }
    
    func test_postRequest_handlesNoDataRequest() {
        let resource = ResourceModel(url: makeUrl(), method: .post(nil))
        testRequestFor(resource: resource) { request in
            XCTAssertNil(request.httpBodyStream)
        }
    }
    
    func test_postRequest_includesCorrectHeaders() {
        let resource = ResourceModel(url: makeUrl(), method: .post(nil), headers: ["Content-Type": "application/json"])
        testRequestFor(resource: resource) { request in
            XCTAssertEqual(request.allHTTPHeaderFields, resource.headers)
        }
    }
    
    func test_postRequest_completesWithData_whenResponseStatus200() {
        let resource = ResourceModel(url: makeUrl(), method: .post(makeValidData()))
        expectResult(.success(makeValidData()), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 200), error: nil))
    }
    
    func test_postRequest_handlesNoDataResponse_whenStatus204() {
        let resource = ResourceModel(url: makeUrl(), method: .post(makeEmptyData()))
        expectResult(.success(nil), for: resource, when: (data: nil, response: makeHttpResponse(statusCode: 204), error: nil))
    }

    func test_postRequest_handlesHTTPErrorResponses() {
        let resource = ResourceModel(url: makeUrl(), method: .post(makeValidData()))
        
        expectResult(.failure(.badRequest), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expectResult(.failure(.unauthorized), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil))
        expectResult(.failure(.forbidden), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 403), error: nil))
        expectResult(.failure(.notFound), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 404), error: nil))
        expectResult(.failure(.serverError), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))
    }

    // MARK: - PUT Tests
    func test_putRequest_createsCorrectPUTRequest() {
        let url = makeUrl()
        let resource = ResourceModel(url: url, method: .put(makeValidData()))
        testRequestFor(resource: resource) { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("PUT", request.httpMethod)
        }
    }

    func test_putRequest_completesWithData_whenResponseStatus200() {
        let resource = ResourceModel(url: makeUrl(), method: .put(makeValidData()))
        expectResult(.success(makeValidData()), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 200), error: nil))
    }

    func test_putRequest_handlesNoDataResponse_whenStatus204() {
        let resource = ResourceModel(url: makeUrl(), method: .put(nil))
        expectResult(.success(nil), for: resource, when: (data: nil, response: makeHttpResponse(statusCode: 204), error: nil))
    }

    func test_putRequest_handlesHTTPErrorResponses() {
        let resource = ResourceModel(url: makeUrl(), method: .put(makeValidData()))
        expectResult(.failure(.badRequest), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expectResult(.failure(.unauthorized), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil))
        expectResult(.failure(.serverError), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))
    }
    
    // MARK: - DELETE Tests
    func test_deleteRequest_createsCorrectDELETERequest() {
        let url = makeUrl()
        let resource = ResourceModel(url: url, method: .delete)
        testRequestFor(resource: resource) { request in
            XCTAssertEqual(url, request.url)
            XCTAssertEqual("DELETE", request.httpMethod)
        }
    }

    func test_deleteRequest_handlesNoDataResponse_whenStatus204() {
        let resource = ResourceModel(url: makeUrl(), method: .delete)
        expectResult(.success(nil), for: resource, when: (data: nil, response: makeHttpResponse(statusCode: 204), error: nil))
    }

    func test_deleteRequest_handlesHTTPErrorResponses() {
        let resource = ResourceModel(url: makeUrl(), method: .delete)
        
        expectResult(.failure(.badRequest), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 400), error: nil))
        expectResult(.failure(.unauthorized), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 401), error: nil))
        expectResult(.failure(.forbidden), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 403), error: nil))
        expectResult(.failure(.notFound), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 404), error: nil))
        expectResult(.failure(.serverError), for: resource, when: (data: makeValidData(), response: makeHttpResponse(statusCode: 500), error: nil))
    }
}

extension HttpClientTests {
    func makeSut(file: StaticString = #filePath, line: UInt = #line) -> HTTPClient {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [UrlProtocolStub.self]
        let session = URLSession(configuration: configuration)
        let sut = HTTPClient(session: session)
        checkMemoryLeak(for: sut, file: file, line: line)
        return sut
    }
    
    func testRequestFor(resource: ResourceModel, action: @escaping (URLRequest) -> Void) {
        let sut = makeSut()
        let exp = expectation(description: "waiting")
        sut.load(resource) { _ in exp.fulfill() }
        var request: URLRequest?
        
        UrlProtocolStub.observerRequest { request = $0 }
        wait(for: [exp], timeout: 1)
        action(request!)
    }
    
    func expectResult(_ expectedResult: Result<Data?, HTTPError>, for resource: ResourceModel, when stub: (data: Data?, response: HTTPURLResponse?, error: Error?), file: StaticString = #filePath, line: UInt = #line) {
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
