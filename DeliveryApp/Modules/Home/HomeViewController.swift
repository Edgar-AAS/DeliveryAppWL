import UIKit

class HomeViewController: UIViewController {
    private lazy var customView: HomeScreen? = {
        return view as? HomeScreen
    }()
    
    private var foodDataSource: (foods: [Food], categories: [String]) = ([],[])
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
        view.backgroundColor = .white.withAlphaComponent(0.95)
        
        viewModel.fetchFoodsBy(category: .burger) { [weak self] foodData, categories in
            self?.foodDataSource = (foodData, categories)
            self?.customView?.reloadTablewViewData()
        }
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            let headerHeight = customView?.headerView.frame.size.height ?? 0.0
            let stackHeight = customView?.categoryLabelAndButtonStack.frame.size.height ?? 0.0
            let heightRemaning = view.frame.size.height - (stackHeight + headerHeight + 130)
            return heightRemaning
        } else {
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductCategorieCell.reuseIdentifier, for: indexPath) as? ProductCategorieCell
            cell?.delegate = self
            cell?.setup(categories: foodDataSource.categories)
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductGridCell.reuseIdentifier, for: indexPath) as? ProductGridCell
            cell?.setup(foodData: foodDataSource.foods)
            cell?.delegate = self
            self.dataSourceCallBack = cell?.reloadDataCallBack
            return cell ?? UITableViewCell()
        }
    }
}

extension HomeViewController: ProductCategorieCellDelegate {
    func productCategoryDidTapped(type: FoodCategoryType) {
        viewModel.fetchFoodsBy(category: type) { [weak self] foodData, categories in
            guard let self = self else { return }
            self.foodDataSource = (foodData, categories)
            self.dataSourceCallBack?(foodDataSource.foods)
        }
    }
}

extension HomeViewController: ProductGridCellDelegate {
    func foodCardDidTapped(foodSelected: Food) {
        viewModel.goToDetailsScreen(food: foodSelected)
    }
}
