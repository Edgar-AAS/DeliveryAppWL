import UIKit

final class ProducDetailsScreen: UIView {
    convenience init(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        self.init(frame: .zero)
        tableView.delegate = delegate
        tableView.dataSource = dataSource
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func setupHeader(with viewData: ProductHeaderViewData) {
        let headerView = ProductDetailsHeader(frame: .init(x: .zero, y: .zero, width: frame.width, height: 540))
        headerView.configure(with: viewData, delegate: self)
        tableView.tableHeaderView = headerView
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedSectionHeaderHeight = 60
        tableView.register(ProductItemCell.self, forCellReuseIdentifier: ProductItemCell.reuseIdentifier)
        tableView.register(SideItemCell.self, forCellReuseIdentifier: SideItemCell.reuseIdentifier)
        tableView.register(SectionHeaderCell.self, forHeaderFooterViewReuseIdentifier: SectionHeaderCell.reuseIdentifier)
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private lazy var bottomView: ProductDetailsBottomView = {
        let bottomView = ProductDetailsBottomView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        return bottomView
    }()
    
    func handleUserInteraction(isEnable: Bool) {
        isUserInteractionEnabled = isEnable
    }
    
    func setupBottomViewDelegate(_ delegate: ProductDetailsBottomViewDelegate) {
        bottomView.delegate = delegate
    }
        
    func updateAmount(animateInfo: ValueAnimateInfo) {
        bottomView.configureTotalAmount(animateInfo: animateInfo)
    }
    
    func updateStepper(dto: StepperModel) {
        bottomView.configureStepper(with: dto)
    }
    
    func updateRequiredOptionsStatus(with status: OptionsStatusType) {
        bottomView.configureButtonState(status: status)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    func reloadSections(at section: Int) {
        UIView.setAnimationsEnabled(false)
        tableView.reloadSections(IndexSet(integer: section), with: .none)
        UIView.setAnimationsEnabled(true)
    }
    
    func reloadRows(at indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

extension ProducDetailsScreen: ProductDetailsHeaderDelegateProtocol {
    func backButtonDidTapped(_ header: ProductDetailsHeader) {
        print(#function)
    }
}

extension ProducDetailsScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(tableView)
        addSubview(bottomView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            bottomView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomView.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
