import Foundation

class LocalData: HTTPClientProtocol {
    func load<T>(_ resource: Resource<T>, completion: @escaping ((Result<T?, HttpError>) -> Void)) where T : Decodable, T : Encodable {
        
    }
    
    private let resource: String
    
    init(resource: String) {
        self.resource = resource
    }

}
