import Foundation

class LocalData: HTTPClientProtocol {
    private let resource: String
    
    init(resource: String) {
        self.resource = resource
    }
    
    func load<T>(_ resource: Resource<T>, completion: @escaping ((Result<Data?, HttpError>) -> Void)) where T : Decodable, T : Encodable {
        if let url = Bundle.main.url(forResource: self.resource, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            } catch {
                print("error \(error)")
            }
        }
    }
}
