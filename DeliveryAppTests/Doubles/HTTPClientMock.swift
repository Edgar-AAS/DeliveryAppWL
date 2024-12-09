import Foundation
@testable import DeliveryApp

final class HTTPClientMock: HTTPClientProtocol {
    private(set) var completion: ((Result<Data?, HTTPError>) -> Void)?
    
    func load(_ resource: ResourceModel, completion: @escaping ((Result<Data?, HTTPError>) -> Void)) {
        self.completion = completion
    }
    
    func failure(_ error: HTTPError) {
        completion?(.failure(error))
    }
    
    func success(_ data: Data?) {
        completion?(.success(data))
    }
}
