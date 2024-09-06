import UIKit

class HomeViewController: UIViewController {
    private lazy var customView: HomeScreen? = {
        return view as? HomeScreen
    }()
    
    private var foodDataSource: (foods: [Food], categories: [FoodCategoryDTO]) = ([],[])
    private var viewModel: HomeViewModelProtocol
    
    init(viewModel: HomeViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var dataSourceCallBack: (([Food]) -> ())?
    
    override func loadView() {
        super.loadView()
        view = HomeScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        customView?.setupTableViewProtocols(delegate: self, dataSource: self)
        
        viewModel.fetchFoodsBy(category: .burger) { [weak self] foodData, categories in
            self?.foodDataSource = (foodData, categories)
            self?.customView?.reloadTablewViewData()
        }
    }
}
//MARK: - UITableViewDataSource & UITableViewDelegate
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            let headerHeight = customView?.headerView.frame.size.height ?? .zero
            let stackHeight = customView?.categoryLabelAndButtonStack.frame.size.height ?? .zero
            let heightRemaning = view.frame.size.height - (stackHeight + headerHeight + 140)
            return heightRemaning
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == .zero {
            return makeProductCategorieCell(tableView, cellForRowAt: indexPath)
        } else {
            return makeProductGridCell(tableView, cellForRowAt: indexPath)
        }
    }
}

//MARK: - Setup Cells
extension HomeViewController {
    func makeProductCategorieCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductCategorieCell.reuseIdentifier, for: indexPath) as? ProductCategorieCell
        cell?.delegate = self
        cell?.setup(categories: foodDataSource.categories)
        return cell ?? UITableViewCell()
    }
    
    func makeProductGridCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductGridCell.reuseIdentifier, for: indexPath) as? ProductGridCell
        cell?.setup(foodData: foodDataSource.foods)
        cell?.delegate = self
        self.dataSourceCallBack = cell?.reloadDataCallBack
        return cell ?? UITableViewCell()
    }
}

// MARK: - Delegate Actions
extension HomeViewController: ProductCategorieCellDelegate {
    func productCategoryDidTapped(categoryType: FoodCategoryType) {
        //
    }
}

extension HomeViewController: ProductGridCellDelegate {
    func foodCardDidTapped(foodSelected: Food) {
        viewModel.goToDetailsScreen(food: foodSelected)
    }
}
