import UIKit

class HomeViewController: UIViewController {
    private lazy var customView: HomeScreen? = {
        return view as? HomeScreen
    }()
    
    private var foodDataSource: [Food] = []
    private var viewModel: HomeViewModelProtocol
    
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
        hideNavigationBar()
        customView?.setupTableViewProtocols(delegate: self, dataSource: self)
       
        viewModel.fetchFoodsBy(category: .drink)
        viewModel.foodDataSource.bind { [weak self] fooData in
            guard let fooData = fooData else { return }
            self?.foodDataSource = fooData
            self?.customView?.reloadTablewViewData()
        }
        view.backgroundColor = .white.withAlphaComponent(0.95)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            let headerHeight = customView?.headerView.frame.size.height ?? 0.0
            let stackHeight = customView?.categoryLabelAndButtonStack.frame.size.height ?? 0.0
            let heightRemaning = view.frame.size.height - (stackHeight + headerHeight + 133.0)
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
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductGridCell.reuseIdentifier, for: indexPath) as? ProductGridCell
            cell?.setup(foodData: foodDataSource)
            return cell ?? UITableViewCell()
        }
    }
}
