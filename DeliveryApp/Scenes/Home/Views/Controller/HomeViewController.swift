import UIKit

final class HomeViewController: UIViewController {
    private lazy var customView: HomeScreen = {
        guard let view = view as? HomeScreen else {
            fatalError("View is not of type HomeScreen")
        }
        return view
    }()

    private var viewModel: HomeViewModelProtocol
    private var dataSourceCallBack: ((HomeViewData.ProductCellViewData) -> Void)?
    
    var routeToNetworkErrorPage: (() -> Void)?
    var routeToProductDetailsPage: ((Int) -> Void)?
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = HomeScreen(delegate: self,dataSource: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureOptionsView()
        fetchProducts()
    }
    
    private func fetchProducts() {
        viewModel.loadProductsToInitialCategory()
        
        viewModel.categoriesOnComplete = { [weak self] in
            self?.customView.reloadTablewViewData()
        }
        
        viewModel.loadProductsOnComplete = { [weak self] dataSource in
            self?.dataSourceCallBack?(dataSource)
        }
    }
    
    private func configureOptionsView() {
        hideNavigationBar()
    }
}

//MARK: - UITableViewDataSource & UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.getHomeCellTypeIn(row: indexPath.row) {
        case .products:
            return makeProductGridCell(tableView, cellForRowAt: indexPath)
        case .categories:
            return makeProductCategorieCell(tableView, cellForRowAt: indexPath)
        case .seeAll:
            return makeSeeAllCategoriesCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            var otherCellsHeight: CGFloat = .zero
            
            let headerHeight = customView.homeHeader.frame.height
                        
            for row in 0..<indexPath.row {
                otherCellsHeight += tableView.rectForRow(at: IndexPath(row: row, section: indexPath.section)).height
            }
            
            let viewHeight = view.frame.size.height
            let remainingHeight = viewHeight - (otherCellsHeight + headerHeight)
            return remainingHeight
        } else {
            return UITableView.automaticDimension
        }
    }
}

//MARK: - Setup Cells
extension HomeViewController {
    func makeSeeAllCategoriesCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SeeAllCategoriesCell.reuseIdentifier, for: indexPath) as? SeeAllCategoriesCell
        return cell ?? UITableViewCell()
    }
    
    func makeProductCategorieCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCategoryCell.reuseIdentifier, for: indexPath) as? ProductCategoryCell
        cell?.delegate = self
        let categories = viewModel.getCategories()
        cell?.configure(with: categories)
        return cell ?? UITableViewCell()
    }
    
    func makeProductGridCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductGridCell.reuseIdentifier, for: indexPath) as? ProductGridCell
        cell?.delegate = self
        dataSourceCallBack = cell?.loadProducts(viewData:)
        return cell ?? UITableViewCell()
    }
}

// MARK: - Delegate Actions
extension HomeViewController: ProductCategoryCellDelegate {
    func productCategoryCell(_ cell: ProductCategoryCell, didTapCategoryWithId categoryId: Int) {
        viewModel.switchCategory(to: categoryId)
    }
}

extension HomeViewController: ProductGridCellDelegate {
    func productGridCell(_ cell: ProductGridCell, didTapProductWithId productId: Int) {
        routeToProductDetailsPage?(productId)
    }
    
    func productGridCell(_ cell: ProductGridCell, shouldFetchMoreProductsToCategory categoryId: Int) {
        viewModel.loadMoreProducts(for: categoryId)
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func didLoseNetworkConnection() {
        routeToNetworkErrorPage?()
    }
}
