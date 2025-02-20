import UIKit

class ProductDetailsViewController: UIViewController {
    private var viewModel: ProductDetailsViewModelProtocol
    private var productDetailsHeader: ProductDetailsHeader?

    var backToHome: (() -> Void)?
    
    private lazy var customView: ProducDetailsScreen? = {
        return view as? ProducDetailsScreen
    }()
    
    override func loadView() {
        super.loadView()
        view = ProducDetailsScreen(delegate: self, dataSource: self)
    }
    
    init(viewModel: ProductDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        hideNavigationBar()
        hideTabBar()
        customView?.setupBottomViewDelegate(self)
        viewModel.fetchProductDetails()
    }
}

//MARK: - ProductDetailsHeaderDelegate
extension ProductDetailsViewController: ProductDetailsHeaderDelegateProtocol {
    func backButtonDidTapped(_ header: ProductDetailsHeader) {
        backToHome?()
    }
}

//MARK: - TableViewDataSource
extension ProductDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.getNumberOfSections()
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfItemsBySection(section)
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.getItemInSection(indexPath) {
        case .sideItem(let sideItemCellViewData):
            return makeSideItemCell(tableView, cellForRowAt: indexPath, viewData: sideItemCellViewData)
        case .quantitativeItem(let productItemCellViewData):
            return makeProductItemCell(tableView, cellForRowAt: indexPath, viewData: productItemCellViewData)
        default:
            return UITableViewCell()
        }
    }
}

//MARK: - UITableViewDelegate
extension ProductDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.updateSideItemState(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderCell.reuseIdentifier) as? SectionHeaderCell
        guard let sectionViewData = viewModel.getSectionViewData(to: section) else {
            return nil
        }
        sectionHeader?.configure(with: sectionViewData)
        return sectionHeader
    }
}

//MARK: - ProductDetailsBottomViewDelegate
extension ProductDetailsViewController: ProductQuantityFooterViewDelegate {
    func productQuantityFooterView(_ footer: ProductQuantityFooterView, didTapStepperWithAction action: StepperActionType) {
        viewModel.updateFooterViewStepper(action: action)
    }
}

//MARK: - ProductDetailsViewModel Delegate Actions
extension ProductDetailsViewController: ProductDetailsViewModelDelegate {
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, shouldEnableUserInteraction: Bool) {
        customView?.handleUserInteraction(isEnable: shouldEnableUserInteraction)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateRequiredOptionsStatus status: OptionsStatusType) {
        customView?.updateRequiredOptionsStatus(with: status)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didChangeBottomViewStepperValue stepperDto: StepperModel) {
        customView?.updateStepper(dto: stepperDto)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateTotalAmount amount: ValueAnimateInfo) {
        customView?.updateAmount(animateInfo: amount)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didExceedOptionLimitInSection section: Int) {
        customView?.reloadSections(at: section)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didChangeStepperValueAt indexPath: IndexPath) {
        customView?.reloadRows(at: indexPath)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didSelectItemAt section: Int) {
        customView?.reloadSections(at: section)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didEnableOptionsInSection section: Int) {
        customView?.reloadSections(at: section)
    }
    
    func productDetailsViewModelDidUpdateUI(_ viewModel: ProductDetailsViewModel) {
        customView?.reloadData()
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateHeaderWith viewData: ProductHeaderViewData) {
        customView?.setupHeader(with: viewData, delegate: self)
    }
}

//MARK: - ProductItemCellDelegate
extension ProductDetailsViewController: ProductItemCellDelegate {
    func productItemCell(_ cell: ProductItemCell, didTapStepperWithAction action: StepperActionType, at indexPath: IndexPath) {
        viewModel.updateAdditionalItemStepper(action: action, indexPath: indexPath)
    }
}

//MARK: - Cell Factories
extension ProductDetailsViewController {
    func makeProductItemCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, viewData: QuantitativeItemViewData) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductItemCell.reuseIdentifier, for: indexPath) as? ProductItemCell
        
        if let stepperDto = viewModel.getStepperDto(in: indexPath) {
            cell?.delegate = self
            cell?.configure(with: viewData, stepper: stepperDto, indexPath: indexPath)
        }
        
        return cell ?? UITableViewCell()
    }
    
    func makeSideItemCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, viewData: SideItemCellViewData) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideItemCell.reuseIdentifier, for: indexPath) as? SideItemCell
        cell?.configure(with: viewData)
        return cell ?? UITableViewCell()
    }
}
