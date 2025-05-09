import Foundation

protocol FetchProductsUseCase {
    func fetch(for categoryId: Int, resetPagination: Bool, completion: @escaping (Result<[ProductDTO], RequestError>) -> Void)
}

final class FetchProducts: FetchProductsUseCase {
    private let httpClient: HTTPClientProtocol
    private var isFetching = false
    
    private var currentPage: Int = 0
    private var totalProducts: Int = 0
    private let pageSize: Int = 10
    
    private var productsDataSource = [ProductDTO]()
    
    var httpProductListResource: ((ProductPagination) -> ResourceModel)?
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }

    func fetch(for categoryId: Int,
               resetPagination: Bool,
               completion: @escaping (Result<[ProductDTO], RequestError>) -> Void) {
        
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
        
        guard let httpResource = httpProductListResource?(
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
            case .success(let data):
                guard let productResponse: ProductPaginatedResponseDTO = data?.toModel() else {
                    completion(.failure(.unknown))
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
