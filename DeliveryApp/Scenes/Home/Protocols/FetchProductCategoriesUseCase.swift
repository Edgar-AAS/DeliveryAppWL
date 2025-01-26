import Foundation

protocol FetchProductCategoriesUseCase {
    func fetch(completion: @escaping (Result<[CategoryResponse], HTTPError>) -> Void)
}
