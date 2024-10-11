import Foundation

class HomeViewModel: HomeViewModelProtocol {
    var productsOnComplete: ((ProductGridCellDataSource) -> Void)?
    var categoriesOnComplete: (() -> Void)?
    
    private var productsDataSource = [Product]()
    private var categoriesDataSource = [ProductCategory]()
    private var totalProducts: Int = 0
    private var currentPage: Int = 0
    private let pageSize: Int = 10
    private var isFetching = false
    
    private let httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    var numberOfRows: Int {
        return 3
    }
    
    func getCategories() -> [ProductCategory] {
        return categoriesDataSource
    }
    
    func loadInitialData() {
        fetchCategories { [weak self] categories in
            guard let self = self else { return }
            self.categoriesDataSource = categories
            self.categoriesOnComplete?()
            
            if let firstCategoryId = categories.first?.id {
                self.fetchProducts(for: firstCategoryId, resetPagination: true)
            }
        }
    }
    
    func loadMoreProducts(for categoryId: Int) {
        fetchProducts(for: categoryId, resetPagination: false)
    }

    func switchCategory(to categoryId: Int) {
        fetchProducts(for: categoryId, resetPagination: true)
    }
    
    private func fetchCategories(completion: @escaping ([ProductCategory]) -> Void) {
        let resource = Resource(
            url: URL(string: "http://localhost:5177/v1/categories")!,
            headers: ["Content-Type": "application/json"],
            modelType: [ProductCategory].self
        )
        
        httpClient.load(resource) { result in
            switch result {
            case .failure(let error):
                print("Error fetching categories: \(error)")
            case .success(let categories):
                guard let categories = categories else {
                    print("No data received for the requested categories.")
                    return
                }
                let activeCategories = categories.filter { $0.isActive }
                completion(activeCategories)
            }
        }
    }
    
    private func fetchProducts(for categoryId: Int, resetPagination: Bool) {
        guard !isFetching else {
            print("Já está buscando dados, aguardando a conclusão...")
            return
        }
        
        if resetPagination {
            resetPaginationState()
        }
        
        guard shouldFetchMoreProducts() else {
            print("Todos os produtos foram carregados. Nenhuma nova requisição será feita.")
            return
        }
        
        isFetching = true
        
        let resource = Resource(
            url: URL(string: "http://localhost:5177/v1/products/category/\(categoryId)")!,
            method: .get([
                URLQueryItem(name: "page", value: "\(currentPage)"),
                URLQueryItem(name: "pageSize", value: "\(pageSize)")
            ]),
            headers: ["Content-Type": "application/json"],
            modelType: ProductResponse.self
        )
        
        httpClient.load(resource) { [weak self] result in
            guard let self = self else { return }
            self.isFetching = false
            
            switch result {
            case .failure(let error):
                print("Error fetching products by category: \(error)")
            case .success(let productResponse):
                guard let productData = productResponse else {
                    print("No valid data")
                    return
                }
        
                if !productData.products.allSatisfy({ $0.categoryId == categoryId }) {
                    print("Esta categoria contém produtos não vinculados a ela")
                    return
                }
                
                self.currentPage += 1
                self.totalProducts = productData.total
                self.productsDataSource.append(contentsOf: productData.products)
                
                let dataSource = ProductGridCellDataSource(categoryId: categoryId, products: self.productsDataSource)
                self.productsOnComplete?(dataSource)
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
