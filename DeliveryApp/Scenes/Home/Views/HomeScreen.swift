import UIKit

class HomeScreen: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    lazy var headerView: HomeHeaderView = {
        let header = HomeHeaderView()
        header.translatesAutoresizingMaskIntoConstraints = false
        return header
    }()
        
    private lazy var homeTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isScrollEnabled = false
        tableView.backgroundColor = .clear
        tableView.register(ProductCategorieCell.self, forCellReuseIdentifier: ProductCategorieCell.reuseIdentifier)
        tableView.register(ProductGridCell.self, forCellReuseIdentifier: ProductGridCell.reuseIdentifier)
        return tableView
    }()
    
    private lazy var findByCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Find by Category"
        label.textColor = .black
        label.font = Fonts.semiBold(size: 16).weight
        return label
    }()
    
    private lazy var seeAllButton: UIButton = {
        let button = UIButton(type:  .system)
        button.setTitle("See All", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = Fonts.bold(size: 14).weight
        button.setTitleColor(Colors.primaryColor, for: .normal)
        return button
    }()
    
    lazy var categoryLabelAndButtonStack = makeStackView(with: [findByCategoryLabel,
                                                                seeAllButton],
                                                         axis: .horizontal)
    
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
        addSubview(headerView)
        addSubview(categoryLabelAndButtonStack)
        addSubview(homeTableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 280),
            
            categoryLabelAndButtonStack.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 24),
            categoryLabelAndButtonStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            categoryLabelAndButtonStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            homeTableView.topAnchor.constraint(equalTo: categoryLabelAndButtonStack.bottomAnchor, constant: 24),
            homeTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            homeTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            homeTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAddiotionalConfiguration() {
        backgroundColor = Colors.backgroundColor
    }
}
