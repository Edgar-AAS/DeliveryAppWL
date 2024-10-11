import UIKit

class ProductDetailsViewController: UITableViewController {
    private var viewModel: ProductDetailsViewModelProtocol
    private var productDetailsHeader: ProductDetailsHeader?
    
    init(viewModel: ProductDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        hideTabBar()
        setupTableViewProperties()
        viewModel.fetchProductDetails()
    }
    
    private func setupTableViewProperties() {
        tableView.register(ProductItemCell.self, forCellReuseIdentifier: ProductItemCell.reuseIdentifier)
        tableView.register(SideItemCell.self, forCellReuseIdentifier: SideItemCell.reuseIdentifier)
        tableView.register(SectionHeaderCell.self, forHeaderFooterViewReuseIdentifier: SectionHeaderCell.reuseIdentifier)
        tableView.estimatedSectionHeaderHeight = 60
        
        productDetailsHeader = ProductDetailsHeader(frame: .init(x: .zero, y: .zero, width: view.frame.width, height: 500))
        tableView.tableHeaderView = productDetailsHeader
    }
    
//MARK: - TableViewDataSource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderCell.reuseIdentifier) as? SectionHeaderCell
        guard let sectionViewData = viewModel.getSectionViewData(to: section) else {
            return nil
        }
        sectionHeader?.configure(with: sectionViewData)
        return sectionHeader
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.updateSideItemState(at: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfItemsBySection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.getItemInSection(indexPath) {
        case .sideItem(let sideItemCellViewData):
            return makeSideItemCell(tableView, cellForRowAt: indexPath, viewData: sideItemCellViewData)
        case .regularItem(let productItemCellViewData):
            return makeProductItemCell(tableView, cellForRowAt: indexPath, viewData: productItemCellViewData)
        default:
            return UITableViewCell()
        }
    }
}

//MARK: - ProductDetailsViewModelDelegate
extension ProductDetailsViewController: ProductDetailsViewModelDelegate {
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateHeaderWith viewData: HeaderViewData) {
        productDetailsHeader?.configure(with: viewData)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didExceedOptionLimitInSection section: Int) {
        tableView.reloadSections([section], with: .none)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didChangeStepperValueAt indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didSelectItemAt indexPath: IndexPath) {
        tableView.reloadSections([indexPath.section], with: .none)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didEnableOptionsInSection section: Int) {
        tableView.reloadSections([section], with: .none)
    }
    
    func productDetailsViewModelDidUpdateUI(_ viewModel: ProductDetailsViewModel) {
        tableView.reloadData()
    }
}

//MARK: - ProductItemCellDelegate
extension ProductDetailsViewController: ProductItemCellDelegate {
    func productItemCell(_ cell: ProductItemCell, didTapStepperWithAction action: StepperActionType, at indexPath: IndexPath) {
        viewModel.updateStepper(action: action, indexPath: indexPath)
    }
}

//MARK: - Cell Factories
extension ProductDetailsViewController {
    func makeProductItemCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, viewData: ProductItemCellViewData) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductItemCell.reuseIdentifier, for: indexPath) as? ProductItemCell
        
        if let stepperDto = viewModel.getStepperDto(in: indexPath) {
            cell?.delegate = self
            cell?.configure(with: viewData, stepperDto: stepperDto, indexPath: indexPath)
        }
        return cell ?? UITableViewCell()
    }
    
    func makeSideItemCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, viewData: SideItemCellViewData) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideItemCell.reuseIdentifier, for: indexPath) as? SideItemCell
        cell?.configure(with: viewData, indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
}
