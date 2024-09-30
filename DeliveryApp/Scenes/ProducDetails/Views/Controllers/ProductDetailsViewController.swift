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
        tableView.register(ProductItemCell.self, forCellReuseIdentifier: ProductItemCell.reuseIdentifier)
        tableView.register(SideItemCell.self, forCellReuseIdentifier: SideItemCell.reuseIdentifier)
        tableView.register(SectionHeaderCell.self, forHeaderFooterViewReuseIdentifier: SectionHeaderCell.reuseIdentifier)
        tableView.estimatedSectionHeaderHeight = 60
        tableView.allowsSelection = false
        
        hideNavigationBar()
        hideTabBar()
        productDetailsHeader = ProductDetailsHeader(frame: .init(x: .zero, y: .zero, width: view.frame.width, height: 500))
        tableView.tableHeaderView = productDetailsHeader
        
        viewModel.productDetailsOnComplete = { [weak self] in
            self?.tableView.reloadData()
        }
        
        viewModel.fetchProductDetails()
    }
    
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
    
    //MARK: - ProductDetailsViewModel Actions
    extension ProductDetailsViewController: ProductDetailsViewModelDelegate {
        func didEnableOptions(_ viewModel: ProductDetailsViewModel, in section: Int) {
            tableView.reloadSections([section], with: .none)
        }
        
        func stepperValueDidChange(_ viewModel: ProductDetailsViewModel, at indexPath: IndexPath) {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        func didExceedOptionsLimit(_ viewModel: ProductDetailsViewModel, in section: Int) {
            tableView.reloadSections([section], with: .none)
        }
        
        func favoriteTogleWith(_ viewModel: ProductDetailsViewModel, state: Bool) {
            //        customView?.updateFavoriteButtonState(state)
        }
        
        func didUpdateHeaderView(_ viewModel: ProductDetailsViewModel, with viewData: HeaderViewData) {
            productDetailsHeader?.configure(with: viewData)
            tableView.reloadData()
        }
    }
    
    //MARK: - ProductDetailsScreen Actions
    extension ProductDetailsViewController: ProductDetailsScreenDelegate {
        func backButtonDidTapped(_ view: ProductDetailsBottomView) {
            //
        }
        
        func favoriteButtonDidTapped(_ view: ProductDetailsBottomView) {
            //
        }
    }
    
    extension ProductDetailsViewController  {
        func makeProductItemCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, viewData: ProductItemCellViewData) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProductItemCell.reuseIdentifier, for: indexPath) as? ProductItemCell
            cell?.customStepper.plusButtonTapped = { [weak self] in
                self?.viewModel.incrementStepperValue(at: indexPath)
            }
            
            cell?.customStepper.minusButtonTapped = { [weak self] in
                self?.viewModel.decrementStepperValue(at: indexPath)
            }
            
            cell?.plusButtonCellDidTapped = { [weak self] in
                self?.viewModel.incrementStepperValue(at: indexPath)
            }
            
            let stepperValue = viewModel.stepperValues[indexPath] ?? .zero
            let isVisible = viewModel.isOptionsEnabled[indexPath.section] ?? true
            cell?.configure(with: viewData, stepperValue: stepperValue, isVisible: isVisible)
            return cell ?? UITableViewCell()
        }
        
        func makeSideItemCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, viewData: SideItemCellViewData) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: SideItemCell.reuseIdentifier, for: indexPath) as? SideItemCell
            cell?.sideItemDidSelected = { [weak self] in
                self?.viewModel.updateSideItemState(at: indexPath)
                tableView.reloadSections([indexPath.section], with: .none)
            }
            cell?.configure(with: viewData)
            return cell ?? UITableViewCell()
        }
    }
