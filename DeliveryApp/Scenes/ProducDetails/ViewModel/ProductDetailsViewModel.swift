import Foundation

protocol ProductDetailsViewModelDelegate: AnyObject {
    func favoriteTogleWith(_ viewModel: ProductDetailsViewModel, state: Bool)
    func didUpdateHeaderView(_ viewModel: ProductDetailsViewModel, with viewData: HeaderViewData)
    func didExceedOptionsLimit(_ viewModel: ProductDetailsViewModel, in section: Int)
    func stepperValueDidChange(_ viewModel: ProductDetailsViewModel, at indexPath: IndexPath)
    func didEnableOptions(_ viewModel: ProductDetailsViewModel, in section: Int)
}

protocol ProductDetailsViewModelProtocol {
    func getNumberOfSections() -> Int
    func getNumberOfItemsBySection(_ section: Int) -> Int
    func getSectionName(_ section: Int) -> String
    func getSectionViewData(to section: Int) -> SectionHeaderViewData?
    func getItemInSection(_ indexPath: IndexPath) -> SectionType?
    func incrementStepperValue(at indexPath: IndexPath)
    func decrementStepperValue(at indexPath: IndexPath)
    func updateSideItemState(at indexPath: IndexPath)
    func fetchProductDetails()
    var productDetailsOnComplete: (() -> Void)? { get set }
    var stepperValues: [IndexPath: Int] { get set }
    var isOptionsEnabled: [Int: Bool] { get set }
}

enum SectionType {
    case sideItem(SideItemCellViewData)
    case regularItem(ProductItemCellViewData)
//    case drinkItem
}

class ProductDetailsViewModel: ProductDetailsViewModelProtocol {
    private var isSideItemSelected: [IndexPath : Bool] = [:]
    private var isBackEnabledOtions: [Int: Bool] = [:]
    private let httpClient: HTTPClientProtocol
    private let productId: Int
    private var activeSections: [Section]?
    private var lastIndex: IndexPath?
    
    var isOptionsEnabled: [Int: Bool] = [:]
    var stepperValues: [IndexPath: Int] = [:]
    
    var productDetailsOnComplete: (() -> Void)?
    
    weak var delegate: ProductDetailsViewModelDelegate?
    
    init(httpClient: HTTPClientProtocol, productId: Int) {
        self.httpClient = httpClient
        self.productId = productId
    }
    
    func updateSideItemState(at indexPath: IndexPath) {
        let isSelected = isSideItemSelected[indexPath] ?? false

        if lastIndex == indexPath {
            isSideItemSelected[indexPath] = !isSelected
        } else {
            if let lastIndex = lastIndex {
                isSideItemSelected[lastIndex] = false
            }
            isSideItemSelected[indexPath] = true
        }
        lastIndex = indexPath
    }
    
    func getItemInSection(_ indexPath: IndexPath) -> SectionType? {
        guard let section = activeSections?[indexPath.section] else  { return nil }
        let item = section.items[indexPath.row]
        let isSelected = isSideItemSelected[indexPath] ?? false
        
        if section.isSideItem {
            return .sideItem(SideItemCellViewData(item: item, isSelected: isSelected))
        }
        
        return .regularItem(ProductItemCellViewData(item: item))
    }
    
    func getNumberOfSections() -> Int {
        return activeSections?.count ?? 0
    }
    
    func getSectionName(_ section: Int) -> String {
        return activeSections?[section].name ?? ""
    }
    
    func getNumberOfItemsBySection(_ section: Int) -> Int {
        return activeSections?[section].items.count ?? 0
    }
    
    func getSectionViewData(to section: Int) -> SectionHeaderViewData? {
        guard let sectionData = activeSections?[section] else {
            return nil
        }
        return SectionHeaderViewData(section: sectionData)
    }
    
    func incrementStepperValue(at indexPath: IndexPath) {
        guard let section = activeSections?[indexPath.section] else { return }
        let currentValue = stepperValues[indexPath] ?? 0
        
        if currentValue < section.limitOptions {
            let newValue = currentValue + 1
            stepperValues[indexPath] = newValue
            
            if isLimitExceeded(in: indexPath) {
                isOptionsEnabled[indexPath.section] = false
                delegate?.didExceedOptionsLimit(self, in: indexPath.section)
                return
            }
            delegate?.stepperValueDidChange(self, at: indexPath)
        }
    }
    
    func decrementStepperValue(at indexPath: IndexPath) {
        guard activeSections?[indexPath.section] != nil else { return }
        
        let currentValue = stepperValues[indexPath] ?? 0
    
        if currentValue > 0 {
            let newValue = currentValue - 1
            stepperValues[indexPath] = newValue
            
            let isBackEnableOptionsByPath = isBackEnabledOtions[indexPath.section] ?? false
            
            if isBackEnableOptionsByPath {
                isOptionsEnabled[indexPath.section] = true
                isBackEnabledOtions[indexPath.section] = false
                delegate?.didEnableOptions(self, in: indexPath.section)
                return
            }
            delegate?.stepperValueDidChange(self, at: indexPath)
        }
    }
    
    func fetchProductDetails() {
        let resource = Resource(
            url: URL(string: "http://localhost:5177/v1/products/details/\(productId)")!,
            headers: ["Content-Type": "application/json"],
            modelType: ProductDetailsResponse.self
        )
        
        httpClient.load(resource) { [weak self] result in
            switch result {
            case .success(let model):
                if let productDetailsResponse = model {
                    self?.activeSections = productDetailsResponse.sections
                        .filter({ $0.isActive })
                        .sorted(by: { $0.selectionOrder > $1.selectionOrder })
                    
                    self?.updateHeaderView(with: productDetailsResponse)
                    self?.productDetailsOnComplete?()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func isLimitExceeded(in indexPath: IndexPath) -> Bool {
        let section = indexPath.section
        if let activeSection = activeSections?[section] {
            let total = stepperValues.filter { $0.key.section == section }.map { $0.value }.reduce(0, +)
            
            if total == activeSection.limitOptions {
                isBackEnabledOtions[indexPath.section] = true
                return true
            }
        }
        return false
    }
    
    private func updateHeaderView(with data: ProductDetailsResponse) {
        let headerViewData = HeaderViewData(productDatailsResponse: data)
        delegate?.didUpdateHeaderView(self, with: headerViewData)
    }
    
    private func updateTotalAmount() {
        //bottomView
    }
}
