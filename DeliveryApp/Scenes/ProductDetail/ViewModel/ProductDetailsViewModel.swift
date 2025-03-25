import Foundation

final class ProductDetailsViewModel: ProductDetailsViewModelProtocol {
    private var lastSelectedIndexPath: [IndexPath : Bool] = [:]
    
    private var optionsReenabled: [Int: Bool] = [:]
    private var isSectionOptionsEnabled: [Int: Bool] = [:]
    private var sections: [SectionDTO]?
    
    private var quantitativeItems: [IndexPath: QuantitativeItem] = [:]
    private var selectableItems: [IndexPath: SelectableItem] = [:]
    
    private var fromValue: Double = .zero
    
    private var footerMinimumStepperVaue: Int = 1
    private var footerCurrentStepperValue: Int = 1
        
    weak var delegate: ProductDetailsViewModelDelegate?
    
    private let fetchProductDetailsUseCase: FetchProductDetailsUseCase
    
    init(fetchDetails: FetchProductDetailsUseCase) {
        self.fetchProductDetailsUseCase = fetchDetails
    }
}

//MARK: - Fetch Details
extension ProductDetailsViewModel {
    func fetchProductDetails() {
        fetchProductDetailsUseCase.fetch { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let response):
                configure(with: response)
            case .failure(let error):
                return
            }
        }
    }
    
    private func configure(with response: ProductDTO) {
        configureSections(sections: response.sections)
        updateHeader(data: response)
        updateUI()
        updateFooterStepper(with: .init(currentValue: footerCurrentStepperValue, minValue: footerMinimumStepperVaue))
        updateOrderPrice()
    }

    private func configureSections(sections: [SectionDTO]) {
        self.sections = sections.sorted { $0.selectionOrder < $1.selectionOrder }
    }
    
    private func updateUI() {
        delegate?.productDetailsViewModelDidRefreshUI(self)
    }
    
    private func updateFooterStepper(with footerStepperModel: FooterStepperModel) {
        delegate?.productDetailsViewModel(self, didChangeFooterStepperValue: footerStepperModel)
    }
    
    private func updateHeader(data: ProductDTO) {
        let productHeaderViewData = ProductDetailViewData.ProductHeaderViewData(
            name: data.name,
            description: data.description,
            deliveryFee: data.deliveryFee?.format(with: .currency) ?? "Free Delivery",
            basePrice: "\(data.discountPrice ?? data.price)",
            rating: "\(data.rating)",
            images: data.images.sorted(by: { $0.id < $1.id }))
        
        delegate?.productDetailsViewModel(self, didUpdateHeaderWith: productHeaderViewData)
    }
}

//MARK: - FooterView Handle
extension ProductDetailsViewModel {
    func updateFooterStepper(with action: StepperActionType) {
        switch action {
        case .add:
            footerCurrentStepperValue += 1
        case .remove:
            if footerCurrentStepperValue > footerMinimumStepperVaue {
                footerCurrentStepperValue -= 1
            }
        }
        
        let footerStepperModel = FooterStepperModel(currentValue: footerCurrentStepperValue, minValue: footerMinimumStepperVaue)
        updateFooterStepper(with: footerStepperModel)
        updateOrderPrice()
    }
}

// MARK: - Price Calculation
extension ProductDetailsViewModel {
    private func updateOrderPrice() {
        let total = calculateOrderPrice() * Double(footerCurrentStepperValue)
        let valueInfo = ProductAAmountModel(fromValue: fromValue, toValue: total)
        
        fromValue = total
        delegate?.productDetailsViewModel(self, didUpdateTotalPrice: valueInfo)
        updateRequiredOptionsStatus()
    }
    
    private func calculateOrderPrice() -> Double {
        let quantitativeTotal = calculateQuantitativeItemsAmount()
        let selectableTotal = calculateSelectableItemsAmount()
        return quantitativeTotal + selectableTotal
    }
    
    private func calculateSelectableItemsAmount() -> Double {
        return selectableItems
            .filter({ $0.value.isSelected })
            .reduce(.zero, { $0 + $1.value.price })
    }
    
    private func calculateQuantitativeItemsAmount() -> Double {
        return quantitativeItems
            .filter { indexPath, item in
                guard let section = sections?[indexPath.section] else { return false }
                return !section.isRemovable
            }
            .reduce(.zero) { $0 + ($1.value.price * Double($1.value.quantity))}
    }
}

// MARK: - Section Data Handling
extension ProductDetailsViewModel {
    func getItemInSection(_ indexPath: IndexPath) -> ProductItemType {
        guard let section = sections?[indexPath.section] else { return .unknown }
        let item = section.items[indexPath.row]
        
        if section.isSideItem, let selectableItem = getSelectableItem(item, indexPath: indexPath) {
            return .selectableItem(selectableItem)
        }
        
        if let quantitativeItem = getQuantitativeItem(with: item, indexPath: indexPath, isRemovable: section.isRemovable) {
            return .quantitativeItem(quantitativeItem)
        }
        
        return .unknown
    }
    
    func getNumberOfSections() -> Int {
        return sections?.count ?? .zero
    }
    
    func getNumberOfItemsBySection(_ section: Int) -> Int {
        return sections?[section].items.count ?? .zero
    }
    
    private func getSelectableItem(_ item: ItemDTO, indexPath: IndexPath) -> ProductDetailViewData.SelectableItemViewData? {
        let selectableItem = SelectableItem(
            id: item.id,
            name: item.name,
            price: item.price,
            imageUrl: item.imageUrl,
            isSelected: selectableItems[indexPath]?.isSelected ?? false
        )
        
        selectableItems[indexPath] = selectableItem
        
        guard let selectableSafeItem = selectableItems[indexPath] else { return nil }
        
        let selectableItemViewData = ProductDetailViewData.SelectableItemViewData(
            name: selectableSafeItem.name,
            price: selectableSafeItem.price.format(with: .currency),
            image: selectableSafeItem.imageUrl,
            isSelected: selectableSafeItem.isSelected
        )
        return selectableItemViewData
    }
    
    private func getQuantitativeItem(with item: ItemDTO, indexPath: IndexPath, isRemovable: Bool) -> ProductDetailViewData.QuantitativeItemViewData? {
        let quantitativeItem = QuantitativeItem(
            name: item.name,
            price: item.price,
            imageUrl: item.imageUrl,
            quantity: quantitativeItems[indexPath]?.quantity ?? .zero)
        
        quantitativeItems[indexPath] = quantitativeItem
        
        guard let quantitativeSafeItem = quantitativeItems[indexPath], let currentValue = quantitativeItems[indexPath]?.quantity else { return nil }
        
        let stepperModel = StepperModel(
            currentValue: currentValue,
            minValue: .zero,
            isEnabled: isSectionOptionsEnabled[indexPath.section] ?? true
        )
        
        let quantitativeItemViewData = ProductDetailViewData.QuantitativeItemViewData(
            name: quantitativeSafeItem.name,
            price: quantitativeSafeItem.price.format(with: .currency),
            image: quantitativeSafeItem.imageUrl,
            isRemovable: isRemovable,
            stepperModel: stepperModel
        )
        
        return quantitativeItemViewData
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


//MARK: - SelectableItem Handle
extension ProductDetailsViewModel {
    func updateSelectableItemState(at indexPath: IndexPath) {
        guard let section = sections?[indexPath.section] else  { return }
        
        if section.isSideItem {
            switchSelectableItemState(indexPath: indexPath)
        }
    }
    
    private func switchSelectableItemState(indexPath: IndexPath) {
        delegate?.productDetailsViewModel(self, shouldAllowUserInteraction: false)
        
        let isSelected = selectableItems[indexPath]?.isSelected ?? false
        
        if let lastIndex = lastSelectedIndexPath.first(where: { $0.key.section == indexPath.section }) {
            selectableItems[lastIndex.key]?.isSelected = false
            lastSelectedIndexPath.removeValue(forKey: lastIndex.key)
        }
        
        selectableItems[indexPath]?.isSelected = !isSelected
        
        if selectableItems[indexPath]?.isSelected == true {
            lastSelectedIndexPath[indexPath] = true
        }
        
        delegate?.productDetailsViewModel(self, didSelectItemInSection: indexPath.section)
        updateOrderPrice()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) { [weak self] in
            guard let self else { return }
            delegate?.productDetailsViewModel(self, shouldAllowUserInteraction: true)
        }
    }
}

//MARK: - ItemStepper Handle
extension ProductDetailsViewModel {
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
        if let limitOptionsInSection = sections?[indexPath.section].limitOptions,
           let currentValue = quantitativeItems[indexPath]?.quantity {
            
            if currentValue < limitOptionsInSection {
                quantitativeItems[indexPath]?.quantity += 1
                
                if isLimitExceeded(in: indexPath.section, limitOptions: limitOptionsInSection) {
                    isSectionOptionsEnabled[indexPath.section] = false
                    delegate?.productDetailsViewModel(self, didExceedSelectionLimitInSection: indexPath.section)
                    return
                }
            }
            
            delegate?.productDetailsViewModel(self, didUpdateStepperValueForItemAt: indexPath)
        }
    }
    
    private func decrementStepperValue(at indexPath: IndexPath) {
        if let currentValue = quantitativeItems[indexPath]?.quantity {
            if currentValue > 0 {
                let isSectionOptionsReenabled = optionsReenabled[indexPath.section] ?? false
                
                quantitativeItems[indexPath]?.quantity -= 1
                
                if isSectionOptionsReenabled {
                    isSectionOptionsEnabled[indexPath.section] = true
                    optionsReenabled[indexPath.section] = false
                    delegate?.productDetailsViewModel(self, didEnableOptionsInSection: indexPath.section)
                    return
                }
                
                delegate?.productDetailsViewModel(self, didUpdateStepperValueForItemAt: indexPath)
            }
        }
    }
    
    private func isLimitExceeded(in section: Int, limitOptions: Int) -> Bool {
        let total = quantitativeItems
            .filter({ $0.key.section == section})
            .map { $0.value.quantity }.reduce(0, +)
        
        if total >= limitOptions {
            optionsReenabled[section] = true
            return true
        }
        return false
    }
}

//MARK: - Required Options Status
private extension ProductDetailsViewModel {
    func updateRequiredOptionsStatus() {
        if let sections = sections {
            let status = checkIfAllRequiredOptionIsSelected(at: sections)
            delegate?.productDetailsViewModel(self, didUpdateRequiredOptionsCompletionStatus: status)
        }
    }
    
    func checkIfAllRequiredOptionIsSelected(at sections: [SectionDTO]) -> OptionsStatusType {
        let requiredSelectableItemSections = sections.filter { $0.isRequired && $0.isSideItem }
            .filter { section in
                section.items.contains { item in
                    selectableItems.values.contains { $0.id == item.id && $0.isSelected }
                }
            }
            .count
        
        let requiredAdditionalItemsCount = sections.filter { $0.isRequired && !$0.isSideItem }
            .filter { section in
                let totalQuantity = quantitativeItems.values.reduce(0) { $0 + $1.quantity }
                return totalQuantity == section.limitOptions
            }
            .count
        
        return ifRequiredOptionsAreSelected(sections: sections,
                                            requiredSelectableItemSections,
                                            requiredAdditionalItemsCount) ? .done : .pending
    }

    func ifRequiredOptionsAreSelected(sections: [SectionDTO], _ requiredSideItemSections: Int, _ requiredAdditionalItemsSections: Int) -> Bool {
        let requiredSideItemsSectionsCount = sections.filter { $0.isRequired && $0.isSideItem }.count
        let requiredAdditionalItemsSectionsCount = sections.filter { $0.isRequired && !$0.isSideItem }.count
        
        return requiredSideItemSections == requiredSideItemsSectionsCount
        && requiredAdditionalItemsSections == requiredAdditionalItemsSectionsCount
    }
}
