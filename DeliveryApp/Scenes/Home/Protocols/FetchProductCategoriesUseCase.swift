import Foundation

protocol FetchProductCategoriesUseCase {
    func fetch(completion: @escaping (Result<[ProductCategoryResponse], HTTPError>) -> Void)
}
