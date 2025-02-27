import Foundation
@testable import DeliveryApp

final class HTTPClientMock: HTTPClientProtocol {
    private(set) var completion: ((Result<Data?, RequestError>) -> Void)?
    
    func load(_ resource: ResourceModel, completion: @escaping ((Result<Data?, RequestError>) -> Void)) {
        self.completion = completion
    }
    
    func failure(_ error: RequestError) {
        completion?(.failure(error))
    }
    
    func success(_ data: Data?) {
        completion?(.success(data))
    }
}
