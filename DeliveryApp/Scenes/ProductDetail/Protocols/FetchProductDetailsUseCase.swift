import Foundation

protocol FetchProductDetailsUseCase {
    func fetch(completion: @escaping ((Result<Product, RequestError>) -> Void))
}
