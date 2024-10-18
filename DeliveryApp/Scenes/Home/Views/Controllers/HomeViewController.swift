import UIKit

class HomeViewController: UIViewController {
    private lazy var customView: HomeScreen? = {
        return view as? HomeScreen
    }()

    private var viewModel: HomeViewModelProtocol
    private var dataSourceCallBack: ((ProductGridCellDataSource) -> Void)?
    
    var productDetailsCallback: ((Int) -> Void)?
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = HomeScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        hideNavigationBar()
        customView?.setupTableViewProtocols(delegate: self, dataSource: self)
        
        viewModel.categoriesOnComplete = { [weak self] in
            self?.customView?.reloadTablewViewData()
        }
        
        viewModel.productsOnComplete = { [weak self] dataSource in
            self?.dataSourceCallBack?(dataSource)
        }
        
        viewModel.loadInitialData()
    }
}

//MARK: - UITableViewDataSource & UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == .zero {
            return makeSeeAllCategoriesCell(tableView, cellForRowAt: indexPath)
        } else if indexPath.row == 1 {
            return makeProductCategorieCell(tableView, cellForRowAt: indexPath)
        } else {
            return makeProductGridCell(tableView, cellForRowAt: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            var otherCellsHeight: CGFloat = .zero
            
            guard  let headerHeight = customView?.homeHeader.frame.height else {
                return UITableView.automaticDimension
            }
                        
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
        cell?.delegate = self
        return cell ?? UITableViewCell()
    }
    
    func makeProductCategorieCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCategorieCell.reuseIdentifier, for: indexPath) as? ProductCategorieCell
        cell?.delegate = self
        cell?.setup(categories: viewModel.getCategories())
        return cell ?? UITableViewCell()
    }
    
    func makeProductGridCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductGridCell.reuseIdentifier, for: indexPath) as? ProductGridCell
        cell?.delegate = self
        dataSourceCallBack = cell?.loadProducts(dataSource:)
        return cell ?? UITableViewCell()
    }
}

// MARK: - Delegate Actions
extension HomeViewController: ProductCategorieCellDelegate {
    func productCategoryDidTapped(categoryId: Int) {
        viewModel.switchCategory(to: categoryId)
    }
}

extension HomeViewController: ProductGridCellDelegate {
    func productCardDidTapped(productSelected: Product) {
        productDetailsCallback?(productSelected.id)
    }
    
    func fetchProductsIfNeeded(categoryId: Int) {
        viewModel.loadMoreProducts(for: categoryId)
    }
}

extension HomeViewController: SeeAllCategoriesCellDelegate {
    func seeAllButtonDidTapped(_ cell: SeeAllCategoriesCell) {
        
    }
}
