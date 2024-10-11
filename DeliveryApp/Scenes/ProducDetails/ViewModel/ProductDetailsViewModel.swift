import Foundation

class ProductDetailsViewModel: ProductDetailsViewModelProtocol {
    private var isSideItemSelected: [IndexPath : Bool] = [:]
    private var optionsReenabled: [Int: Bool] = [:]
    private var lastIndex: [IndexPath : Bool] = [:]
    private var isOptionsEnabled: [Int: Bool] = [:]
    private var activeSections: [Section]?
    
    weak var delegate: ProductDetailsViewModelDelegate?
    
    private let fetchDetails: FetchProductDetailsUseCase
    
    init(fetchDetails: FetchProductDetailsUseCase) {
        self.fetchDetails = fetchDetails
    }
    
    //MARK: - Fetch Details
    func fetchProductDetails() {
        fetchDetails.fetch { [weak self] result in
            switch result {
            case .success(let productDetailsResponse):
                guard let self else { return }
                self.activeSections = productDetailsResponse.sections
                    .filter({ $0.isActive })
                    .sorted(by: { $0.selectionOrder < $1.selectionOrder })
                
                self.updateHeaderView(with: productDetailsResponse)
                self.delegate?.productDetailsViewModelDidUpdateUI(self)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    //MARK: - Section DataSource
    func getItemInSection(_ indexPath: IndexPath) -> SectionType? {
        guard let section = activeSections?[indexPath.section] else  { return nil }
        
        let item = section.items[indexPath.row]
        let isSelected = isSideItemSelected[indexPath] ?? false
        
        if section.isSideItem {
            return .sideItem(SideItemCellViewData(item: item, isSelected: isSelected))
        }
        return .regularItem(productItemCellViewDataMapper(item: item, isRemovable: section.isRemovable))
    }
    
    func getNumberOfSections() -> Int {
        return activeSections?.count ?? .zero
    }
    
    func getSectionName(_ section: Int) -> String {
        return activeSections?[section].name ?? String()
    }
    
    func getNumberOfItemsBySection(_ section: Int) -> Int {
        return activeSections?[section].items.count ?? .zero
    }
    
    func getSectionViewData(to section: Int) -> SectionHeaderViewData? {
        guard let sectionData = activeSections?[section] else {
            return nil
        }
        return SectionHeaderViewData(section: sectionData)
    }
    
    //MARK: - SideItem DataSource
    func updateSideItemState(at indexPath: IndexPath) {
        guard let section = activeSections?[indexPath.section] else  { return }
        
        if section.isSideItem {
            switchSideItemState(indexPath: indexPath)
        }
    }
    
    //MARK: - SideItem Handle
    private func switchSideItemState(indexPath: IndexPath) {
        let isSelected = isSideItemSelected[indexPath] ?? false
        
        if let lastIndex = lastIndex.first(where: { $0.key.section == indexPath.section }) {
            isSideItemSelected[lastIndex.key] = false
            self.lastIndex.removeValue(forKey: lastIndex.key)
        }
        
        isSideItemSelected[indexPath] = !isSelected
        
        if isSideItemSelected[indexPath] == true {
            lastIndex[indexPath] = true
        }
        
        delegate?.productDetailsViewModel(self, didSelectItemAt: indexPath)
    }
    
    //MARK: - Stepper DataSource
    func getStepperDto(in indexPath: IndexPath) -> StepperDTO? {
        guard let section = activeSections?[indexPath.section] else { return nil }
        
        let isEnabled = isOptionsEnabled[indexPath.section] ?? true
        let item = section.items[indexPath.row]
        let dto: StepperDTO = .init(currentValue: item.quantity, isEnabled: isEnabled)
        return dto
    }
    
    //MARK: - Stepper Handle
    func updateStepper(action: StepperActionType, indexPath: IndexPath) {
        switch action {
        case .add:
            incrementStepperValue(at: indexPath)
        case .remove:
            decrementStepperValue(at: indexPath)
        }
    }
    
    private func incrementStepperValue(at indexPath: IndexPath) {
        guard var section = activeSections?[indexPath.section] else { return }
        let item = section.items[indexPath.row]
        
        let currentValue = item.quantity
        
        if currentValue < section.limitOptions {
            section.items[indexPath.row].quantity += 1
            activeSections?[indexPath.section] = section
            
            if isLimitExceeded(in: indexPath) {
                isOptionsEnabled[indexPath.section] = false
                delegate?.productDetailsViewModel(self, didExceedOptionLimitInSection: indexPath.section)
                return
            }
            
            delegate?.productDetailsViewModel(self, didChangeStepperValueAt: indexPath)
        }
    }
    
    private func decrementStepperValue(at indexPath: IndexPath) {
        guard var section = activeSections?[indexPath.section] else { return }
        var item = section.items[indexPath.row]
        let currentValue = item.quantity
        
        if currentValue > 0 {
            item.quantity -= 1
            section.items[indexPath.row] = item
            activeSections?[indexPath.section] = section
            
            let isBackEnableOptions = optionsReenabled[indexPath.section] ?? false
            
            if isBackEnableOptions {
                isOptionsEnabled[indexPath.section] = true
                optionsReenabled[indexPath.section] = false
                delegate?.productDetailsViewModel(self, didEnableOptionsInSection: indexPath.section)
                return
            }
            
            delegate?.productDetailsViewModel(self, didChangeStepperValueAt: indexPath)
        }
    }
    
    private func isLimitExceeded(in indexPath: IndexPath) -> Bool {
        let section = indexPath.section
        if let activeSection = activeSections?[section] {
            let total = activeSection.items.map { $0.quantity }.reduce(0, +)
            
            if total >= activeSection.limitOptions {
                optionsReenabled[indexPath.section] = true
                return true
            }
        }
        return false
    }
    
    //MARK: HeaderView DataSource
    private func updateHeaderView(with data: ProductDetailsResponse) {
        delegate?.productDetailsViewModel(self, didUpdateHeaderWith:  headerViewDataMapper(data: data))
    }
    
    //MARK: Mappers
    private func productItemCellViewDataMapper(item: Item, isRemovable: Bool) -> ProductItemCellViewData {
        .init(
            name: item.name,
            price: item.price,
            image: item.imageUrl,
            isRemovable: isRemovable
        )
    }
    
    private func headerViewDataMapper(data: ProductDetailsResponse) -> HeaderViewData {
        .init(
            name: data.name,
            description: data.description,
            basePrice: data.price,
            deliveryFee: data.deliveryFee,
            rating: data.rating,
            images: data.images
        )
    }
}

