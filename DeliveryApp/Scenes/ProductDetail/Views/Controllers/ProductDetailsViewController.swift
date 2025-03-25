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
        configureOptionsView()
        loadProductDetails()
    }
    
    private func configureOptionsView() {
        customView?.setupBottomViewDelegate(self)
        hideNavigationBar()
        hideTabBar()
    }
    
    private func loadProductDetails() {
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
        case .selectableItem(let selectableItemCellViewData):
            return makeSelectableItemCell(tableView, cellForRowAt: indexPath, viewData: selectableItemCellViewData)
        case .quantitativeItem(let productItemCellViewData):
            return makeQuantitativeItemCell(tableView, cellForRowAt: indexPath, viewData: productItemCellViewData)
        default: return UITableViewCell()
        }
    }
}

//MARK: - UITableViewDelegate
extension ProductDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.updateSelectableItemState(at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = tableView.dequeueReusableHeaderFooterView(withIdentifier: SectionHeaderCell.reuseIdentifier) as? SectionHeaderCell
        guard let sectionViewData = viewModel.getSectionViewData(to: section) else { return nil }
        sectionHeader?.configure(with: sectionViewData)
        return sectionHeader
    }
}

//MARK: - ProductDetailsBottomViewDelegate
extension ProductDetailsViewController: ProductQuantityFooterViewDelegate {
    func stepperDidChange(_ footer: ProductPriceFooter, action: StepperActionType) {
        viewModel.updateFooterStepper(with: action)
    }
}

//MARK: - ProductDetailsViewModel Delegate Actions
extension ProductDetailsViewController: ProductDetailsViewModelDelegate {
    func productDetailsViewModelDidRefreshUI(_ viewModel: ProductDetailsViewModel) {
        customView?.reloadData()
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didChangeFooterStepperValue stepperModel: FooterStepperModel) {
        customView?.updateStepperWith(footerModel: stepperModel)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, shouldAllowUserInteraction isEnabled: Bool) {
        customView?.handleUserInteraction(isEnable: isEnabled)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateRequiredOptionsCompletionStatus status: OptionsStatusType) {
        customView?.updateRequiredOptionsStatus(with: status)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateTotalPrice amount: ProductAAmountModel) {
        customView?.updateAmount(amountModel: amount)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didExceedSelectionLimitInSection section: Int) {
        customView?.reloadSections(at: section)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateStepperValueForItemAt indexPath: IndexPath) {
        customView?.reloadRows(at: indexPath)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didSelectItemInSection section: Int) {
        customView?.reloadSections(at: section)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didEnableOptionsInSection section: Int) {
        customView?.reloadSections(at: section)
    }
    
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateHeaderWith viewData: ProductDetailViewData.ProductHeaderViewData) {
        customView?.setupHeader(with: viewData, delegate: self)
    }
}

//MARK: - ProductItemCellDelegate
extension ProductDetailsViewController: ProductItemCellDelegate {
    func productItemCell(_ cell: QuantitativeItemCell, didTapStepperWithAction action: StepperActionType, at indexPath: IndexPath) {
        viewModel.updateAdditionalItemStepper(action: action, indexPath: indexPath)
    }
}

//MARK: - Cell Factories
extension ProductDetailsViewController {
    func makeQuantitativeItemCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, viewData: ProductDetailViewData.QuantitativeItemViewData) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuantitativeItemCell.reuseIdentifier, for: indexPath) as? QuantitativeItemCell
        cell?.delegate = self
        cell?.configure(with: viewData, indexPath: indexPath)
        return cell ?? UITableViewCell()
    }
    
    func makeSelectableItemCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, viewData: ProductDetailViewData.SelectableItemViewData) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectableItemCell.reuseIdentifier, for: indexPath) as? SelectableItemCell
        cell?.configure(with: viewData)
        return cell ?? UITableViewCell()
    }
}
