import UIKit

final class HomeScreen: UIView {
    private weak var delegate: UITableViewDelegate?
    private weak var dataSource: UITableViewDataSource?
    
    init(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.delegate = delegate
        self.dataSource = dataSource
        super.init(frame: .zero)
        setupView()
    }
    
    lazy var homeHeader = HeaderView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.register(SeeAllCategoriesCell.self, forCellReuseIdentifier: SeeAllCategoriesCell.reuseIdentifier)
        tableView.register(ProductCategoryCell.self, forCellReuseIdentifier: ProductCategoryCell.reuseIdentifier)
        tableView.register(ProductGridCell.self, forCellReuseIdentifier: ProductGridCell.reuseIdentifier)
        return tableView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadTablewViewData() {
        tableView.reloadData()
    }
}

extension HomeScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(homeHeader)
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            homeHeader.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            homeHeader.leadingAnchor.constraint(equalTo: leadingAnchor),
            homeHeader.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tableView.topAnchor.constraint(equalTo: homeHeader.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = Colors.background
    }
}
