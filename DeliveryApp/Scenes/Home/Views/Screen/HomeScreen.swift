import UIKit

class HomeScreen: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    lazy var homeHeader: HeaderView = {
        let header = HeaderView()
        return header
    }()
            
    private lazy var homeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.register(SeeAllCategoriesCell.self, forCellReuseIdentifier: SeeAllCategoriesCell.reuseIdentifier)
        tableView.register(ProductCategorieCell.self, forCellReuseIdentifier: ProductCategorieCell.reuseIdentifier)
        tableView.register(ProductGridCell.self, forCellReuseIdentifier: ProductGridCell.reuseIdentifier)
        return tableView
    }()

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadTablewViewData() {
        homeTableView.reloadData()
    }
    
    func setupTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        homeTableView.delegate = delegate
        homeTableView.dataSource = dataSource
    }
}

extension HomeScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(homeHeader)
        addSubview(homeTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            homeHeader.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            homeHeader.leadingAnchor.constraint(equalTo: leadingAnchor),
            homeHeader.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            homeTableView.topAnchor.constraint(equalTo: homeHeader.bottomAnchor),
            homeTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            homeTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            homeTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAddiotionalConfiguration() {
        backgroundColor = Colors.backgroundColor
    }
}

