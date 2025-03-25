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
    
    func setupHeader(with viewData: ProductDetailViewData.ProductHeaderViewData, delegate: ProductDetailsHeaderDelegateProtocol) {
        let headerView = ProductDetailsHeader(frame: .init(x: .zero, y: .zero, width: frame.width, height: 540))
        headerView.configure(with: viewData, delegate: delegate)
        tableView.tableHeaderView = headerView
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.estimatedSectionHeaderHeight = 60
        tableView.register(QuantitativeItemCell.self, forCellReuseIdentifier: QuantitativeItemCell.reuseIdentifier)
        tableView.register(SelectableItemCell.self, forCellReuseIdentifier: SelectableItemCell.reuseIdentifier)
        tableView.register(SectionHeaderCell.self, forHeaderFooterViewReuseIdentifier: SectionHeaderCell.reuseIdentifier)
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private lazy var footerView: ProductPriceFooter = {
        let bottomView = ProductPriceFooter()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        return bottomView
    }()
    
    func handleUserInteraction(isEnable: Bool) {
        isUserInteractionEnabled = isEnable
    }
    
    func setupBottomViewDelegate(_ delegate: ProductQuantityFooterViewDelegate) {
        footerView.delegate = delegate
    }
        
    func updateAmount(amountModel: ProductAAmountModel) {
        footerView.configureTotalAmount(animateInfo: amountModel)
    }
    
    func updateStepperWith(footerModel: FooterStepperModel) {
        footerView.updateValue(with: footerModel)
    }
    
    func updateRequiredOptionsStatus(with status: OptionsStatusType) {
        footerView.configureButtonState(status: status)
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
        addSubview(footerView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            footerView.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            footerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 110)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
