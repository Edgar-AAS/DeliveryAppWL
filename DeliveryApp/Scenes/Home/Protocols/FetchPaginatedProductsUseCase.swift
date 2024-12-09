import Foundation

protocol FetchPaginatedProductsUseCase {
    func fetch(for categoryId: Int, resetPagination: Bool, completion: @escaping (Result<[Product], HTTPError>) -> Void)
}
