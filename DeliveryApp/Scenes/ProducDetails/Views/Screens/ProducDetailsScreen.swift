import UIKit

class ProducDetailsScreen: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedSectionHeaderHeight = 60
        tableView.register(ProductItemCell.self, forCellReuseIdentifier: ProductItemCell.reuseIdentifier)
        tableView.register(SideItemCell.self, forCellReuseIdentifier: SideItemCell.reuseIdentifier)
        tableView.register(SectionHeaderCell.self, forHeaderFooterViewReuseIdentifier: SectionHeaderCell.reuseIdentifier)
        tableView.tableHeaderView = ProductDetailsHeader(frame: .init(x: .zero, y: .zero, width: frame.width, height: 500))
        return tableView
    }()
}

extension ProducDetailsScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
