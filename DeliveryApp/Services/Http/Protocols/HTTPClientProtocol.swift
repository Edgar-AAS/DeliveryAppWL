import Foundation

protocol HTTPClientProtocol {
    func load(_ resource: ResourceModel, completion: @escaping ((Result<Data?, HttpError>) -> Void))
}
