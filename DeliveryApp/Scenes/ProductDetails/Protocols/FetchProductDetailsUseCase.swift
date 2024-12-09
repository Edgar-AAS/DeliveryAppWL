import Foundation

protocol FetchProductDetailsUseCase {
    func fetch(completion: @escaping ((Result<ProductDetailsResponse, HTTPError>) -> Void))
}
