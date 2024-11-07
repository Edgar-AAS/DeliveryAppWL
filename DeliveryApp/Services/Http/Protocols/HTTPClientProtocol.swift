import Foundation

protocol HTTPClientProtocol {
    func load(_ resource: Resource, completion: @escaping ((Result<Data?, HttpError>) -> Void))
}
