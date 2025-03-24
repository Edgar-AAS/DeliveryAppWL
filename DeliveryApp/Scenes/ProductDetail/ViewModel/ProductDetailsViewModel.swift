import Foundation

final class ProductDetailsViewModel: ProductDetailsViewModelProtocol {
    private var optionsReenabled: [Int: Bool] = [:]
    private var lastSelectedIndexPath: [IndexPath : Bool] = [:]
    private var isSectionOptionsEnabled: [Int: Bool] = [:]
    private var sections: [SectionDTO]?
    
    private var quantitativeItems: [IndexPath: QuantitativeItem] = [:]
    private var selectableItems: [IndexPath: SelectableItem] = [:]
    
    private var fromValue: Double = .zero
    private var currentStepperValue = 1
    private var initialStepperValue = 1
    
    weak var delegate: ProductDetailsViewModelDelegate?
    
    private let fetchDetails: FetchProductDetailsUseCase
    
    init(fetchDetails: FetchProductDetailsUseCase) {
        self.fetchDetails = fetchDetails
    }
}

//MARK: - Fetch Details
extension ProductDetailsViewModel {
    func fetchProductDetails() {
        fetchDetails.fetch { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                print(response)
                configure(with: response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configure(with response: ProductDTO) {
        updateHeaderView(with: response)
        configureSections(sections: response.sections)
        delegate?.productDetailsViewModelDidUpdateUI(self)
        setupInitialStepperValue()
        updateOrderPrice()
    }
    
    private func setupInitialStepperValue() {
        let stepper = makeStepperModel(
            currentValue: currentStepperValue,
            minValue: initialStepperValue,
            isEnabled: true,
            isAnimated: false)
        
        delegate?.productDetailsViewModel(self, didChangeBottomViewStepperValue: stepper)
    }
    
    private func configureSections(sections: [SectionDTO]) {
        self.sections = sections.sorted { $0.selectionOrder < $1.selectionOrder }
    }
}

//MARK: - FooterView Handle
extension ProductDetailsViewModel {
    func updateFooterViewStepper(action: StepperActionType) {
        switch action {
        case .add:
            currentStepperValue += 1
        case .remove:
            if currentStepperValue > initialStepperValue {
                currentStepperValue -= 1
            }
        }
        
        let stepper = makeStepperModel(
            currentValue: currentStepperValue,
            minValue: initialStepperValue,
            isEnabled: true,
            isAnimated: false)
        
        delegate?.productDetailsViewModel(self, didChangeBottomViewStepperValue: stepper)
        updateOrderPrice()
    }
}

// MARK: - Calculation Methods
extension ProductDetailsViewModel {
    private func updateOrderPrice() {
        let total = calculateOrderPrice() * Double(currentStepperValue)
        let valueInfo = ValueAnimateInfo(fromValue: fromValue, toValue: total)
        
        fromValue = total
        delegate?.productDetailsViewModel(self, didUpdateTotalAmount: valueInfo)
        updateRequiredOptionsStatus()
    }
    
    private func calculateOrderPrice() -> Double {
        var total: Double = .zero
        
        guard let sections = sections else { return .zero }
        
        let regularItemsTotal = calculateRegularItems(sections: sections)
        let sideItemsTotal = calculateSideItems()
        total = regularItemsTotal + sideItemsTotal
        return total
    }
    
    private func calculateSideItems() -> Double {
        return selectableItems
            .filter({ $0.value.isSelected })
            .reduce(.zero, { $0 + $1.value.price })
    }
    
    private func calculateRegularItems(sections: [SectionDTO]) -> Double {
        return sections
            .filter( { !$0.isRemovable && !$0.isSideItem })
            .flatMap({ $0.items })
            .reduce(.zero) { $0 +  $1.price * Double($1.quantity) }
    }
}

// MARK: - Section DataSource
extension ProductDetailsViewModel {
    func getItemInSection(_ indexPath: IndexPath) -> SectionType? {
        guard let section = sections?[indexPath.section] else  { return nil }
        
        let item = section.items[indexPath.row]
        
        let isSelected = selectableItems[indexPath]?.isSelected ?? false
        
        if section.isSideItem {
            let selectableItem = SelectableItem(
                id: item.id,
                name: item.name,
                price: item.price,
                imageUrl: item.imageUrl,
                isSelected: isSelected)
            
            selectableItems[indexPath] = selectableItem
            
            guard let selectableSafeItem = selectableItems[indexPath] else { return nil }
            
            let selectableItemViewData = ProductDetailViewData.SelectableItemViewData(
                name: selectableSafeItem.name,
                price: selectableSafeItem.price.format(with: .currency),
                image: selectableSafeItem.imageUrl,
                isSelected: selectableSafeItem.isSelected
            )
            
            return .sideItem(selectableItemViewData)
        }
        
        let quantitativeItem = QuantitativeItem(
            name: item.name,
            price: item.price,
            imageUrl: item.imageUrl,
            quantity: quantitativeItems[indexPath]?.quantity ?? .zero)
        
        quantitativeItems[indexPath] = quantitativeItem
        
        guard let quantitativeSafeItem = quantitativeItems[indexPath] else { return nil }
        
        let quantitativeItemViewData = ProductDetailViewData.QuantitativeItemViewData(
            name: quantitativeSafeItem.name,
            price: quantitativeSafeItem.price.format(with: .currency),
            image: quantitativeSafeItem.imageUrl,
            isRemovable: section.isRemovable)

        return .quantitativeItem(quantitativeItemViewData)
    }

    func getNumberOfSections() -> Int {
        return sections?.count ?? .zero
    }
    
    func getNumberOfItemsBySection(_ section: Int) -> Int {
        return sections?[section].items.count ?? .zero
    }
    
    func getSectionViewData(to section: Int) -> ProductDetailViewData.SectionHeaderViewData? {
        guard let section = sections?[section] else {
            return nil
        }
        
        return ProductDetailViewData.SectionHeaderViewData(
            name: section.name,
            isRequired: section.isRequired,
            limitOptions: section.limitOptions
        )
    }
}


//MARK: - SideItem Handle
extension ProductDetailsViewModel {
    func updateSideItemState(at indexPath: IndexPath) {
        guard let section = sections?[indexPath.section] else  { return }
        
        if section.isSideItem {
            switchSideItemState(indexPath: indexPath)
        }
    }
    
    private func switchSideItemState(indexPath: IndexPath) {
        delegate?.productDetailsViewModel(self, shouldEnableUserInteraction: false)
        
        let isSelected = selectableItems[indexPath]?.isSelected ?? false
        
        if let lastIndex = lastSelectedIndexPath.first(where: { $0.key.section == indexPath.section }) {
            selectableItems[lastIndex.key]?.isSelected = false
            lastSelectedIndexPath.removeValue(forKey: lastIndex.key)
        }
        
        selectableItems[indexPath]?.isSelected = !isSelected
        
        if selectableItems[indexPath]?.isSelected == true {
            lastSelectedIndexPath[indexPath] = true
        }
        
        delegate?.productDetailsViewModel(self, didSelectItemAt: indexPath.section)
        updateOrderPrice()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self else { return }
            delegate?.productDetailsViewModel(self, shouldEnableUserInteraction: true)
        }
    }
}

//MARK: - ItemStepper Handle
extension ProductDetailsViewModel {
    func getStepperDto(in indexPath: IndexPath) -> StepperModel? {
        guard let section = sections?[indexPath.section] else { return nil }
        
        let isEnabled = isSectionOptionsEnabled[indexPath.section] ?? true
        let item = section.items[indexPath.row]
    
        return makeStepperModel(
            currentValue: item.quantity,
            minValue: .zero,
            isEnabled: isEnabled,
            isAnimated: false)
    }
    
    func updateAdditionalItemStepper(action: StepperActionType, indexPath: IndexPath) {
        switch action {
        case .add:
            incrementStepperValue(at: indexPath)
        case .remove:
            decrementStepperValue(at: indexPath)
        }
        updateOrderPrice()
    }
    
    private func incrementStepperValue(at indexPath: IndexPath) {
        guard var section = sections?[indexPath.section] else { return }
        let item = section.items[indexPath.row]
        
        let currentValue = item.quantity
        
        if currentValue < section.limitOptions {
            section.items[indexPath.row].quantity += 1
            sections?[indexPath.section] = section
            
            if isLimitExceeded(in: indexPath) {
                isSectionOptionsEnabled[indexPath.section] = false
                delegate?.productDetailsViewModel(self, didExceedOptionLimitInSection: indexPath.section)
                return
            }
        }
        delegate?.productDetailsViewModel(self, didChangeStepperValueAt: indexPath)
    }
    
    private func decrementStepperValue(at indexPath: IndexPath) {
        guard var section = sections?[indexPath.section] else { return }
        var item = section.items[indexPath.row]
        let currentValue = item.quantity
        
        if currentValue > 0 {
            item.quantity -= 1
            section.items[indexPath.row] = item
            sections?[indexPath.section] = section
            
            let isBackEnableOptions = optionsReenabled[indexPath.section] ?? false
            
            if isBackEnableOptions {
                isSectionOptionsEnabled[indexPath.section] = true
                optionsReenabled[indexPath.section] = false
                delegate?.productDetailsViewModel(self, didEnableOptionsInSection: indexPath.section)
                return
            }
            delegate?.productDetailsViewModel(self, didChangeStepperValueAt: indexPath)
        }
    }
    
    private func isLimitExceeded(in indexPath: IndexPath) -> Bool {
        let section = indexPath.section
        if let activeSection = sections?[section] {
            let total = activeSection.items.map { $0.quantity }.reduce(0, +)
            
            if total >= activeSection.limitOptions {
                optionsReenabled[indexPath.section] = true
                return true
            }
        }
        return false
    }
    
    private func updateHeader(data: ProductDTO) {
        let viewData = ProductDetailMapper.mapToProductHeaderViewData(data)
        delegate?.productDetailsViewModel(self, didUpdateHeaderWith: viewData)
    }
}

//MARK: - HeaderView DataSource
extension ProductDetailsViewModel {
    private func updateHeaderView(with data: ProductDTO) {
        updateHeader(data: data)
    }
}

//MARK: - Required Options Status
extension ProductDetailsViewModel {
    private func updateRequiredOptionsStatus() {
        if let sections = sections {
            let status = checkRequiredOptionsStatus(at: sections)
            delegate?.productDetailsViewModel(self, didUpdateRequiredOptionsStatus: status)
        }
    }
    
    private func checkRequiredOptionsStatus(at sections: [SectionDTO]) -> OptionsStatusType {
        let requiredSideItemSections = sections.filter { $0.isRequired && $0.isSideItem }
            .filter { section in
                section.items.contains { item in
                    selectableItems.values.contains { $0.id == item.id && $0.isSelected }
                }
            }
            .count
        
        let requiredAdditionalItemsCount = sections.filter { $0.isRequired && !$0.isSideItem }
            .filter { section in
                let totalQuantity = section.items.reduce(0) { $0 + $1.quantity }
                return totalQuantity == section.limitOptions
            }
            .count
        
        return ifRequiredOptionsAreSelected(sections: sections,
                                            requiredSideItemSections,
                                            requiredAdditionalItemsCount) ? .done : .pending
    }
    
    
    private func ifRequiredOptionsAreSelected(sections: [SectionDTO], _ requiredSideItemSections: Int, _ requiredAdditionalItemsSections: Int) -> Bool {
        let requiredSideItemsSectionsCount = sections.filter { $0.isRequired && $0.isSideItem }.count
        let requiredAdditionalItemsSectionsCount = sections.filter { $0.isRequired && !$0.isSideItem }.count
        
        return requiredSideItemSections == requiredSideItemsSectionsCount
        && requiredAdditionalItemsSections == requiredAdditionalItemsSectionsCount
    }
}

//MARK: Factories
extension ProductDetailsViewModel {
    func makeStepperModel(currentValue: Int, minValue: Int, isEnabled: Bool, isAnimated: Bool) -> StepperModel {
        let stepperModel = StepperModel(
            currentValue: currentValue,
            minValue: minValue,
            isEnabled: isEnabled,
            isAnimated: isAnimated
        )
        return stepperModel
    }
}
