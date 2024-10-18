import Foundation

class FetchPaginatedProducts: FetchPaginatedProductsUseCase {
    private let httpClient: HTTPClientProtocol
    
    private var productsDataSource = [Product]()
    private var isFetching = false
    
    var resourceCallBack: ((ResourceProductsPagination) -> Resource<ProductResponse>)?
    
    private var currentPage: Int = .zero
    private var totalProducts: Int = .zero
    private let pageSize: Int = 10
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func fetch(for categoryId: Int,
               resetPagination: Bool,
               completion: @escaping (Result<[Product], HttpError>) -> Void) {
        
        guard !isFetching else {
            return
        }
        
        if resetPagination {
            resetPaginationState()
        }
        
        guard shouldFetchMoreProducts() else {
            return
        }
        
        isFetching = true
        
        guard let httpResource = resourceCallBack?(
            .init(categoryId: categoryId,
                  pageSize: pageSize,
                  currentPage: currentPage)
        ) else { 
            completion(.failure(.badRequest))
            return
        }
        
        httpClient.load(httpResource) { [weak self] result in
            guard let self = self else { return }
            
            self.isFetching = false
            
            switch result {
            case .failure(let httpError):
                completion(.failure(httpError))
            case .success(let response):
                guard let productResponse = response else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                self.currentPage += 1
                self.totalProducts = productResponse.total
                self.productsDataSource.append(contentsOf: productResponse.products)
                completion(.success(productsDataSource))
            }
        }
    }
    
    private func resetPaginationState() {
        currentPage = 0
        productsDataSource.removeAll()
    }
    
    private func shouldFetchMoreProducts() -> Bool {
        return productsDataSource.count < totalProducts || totalProducts == 0
    }
}
