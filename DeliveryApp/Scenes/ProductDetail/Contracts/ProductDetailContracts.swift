import Foundation

protocol ProductDetailsViewModelDelegate: AnyObject {
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateHeaderWith viewData: ProductDetailViewData.ProductHeaderViewData)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didExceedSelectionLimitInSection section: Int)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateStepperValueForItemAt indexPath: IndexPath)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didSelectItemInSection section: Int)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didEnableOptionsInSection section: Int)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateTotalPrice amount: ProductAAmountModel)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateRequiredOptionsCompletionStatus status: OptionsStatusType)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didChangeFooterStepperValue stepperModel: FooterStepperModel)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, shouldAllowUserInteraction isEnabled: Bool)
    func productDetailsViewModelDidRefreshUI(_ viewModel: ProductDetailsViewModel)
}

protocol ProductDetailsViewModelProtocol {
    func getNumberOfSections() -> Int
    func getNumberOfItemsBySection(_ section: Int) -> Int
    func getSectionViewData(to section: Int) -> ProductDetailViewData.SectionHeaderViewData?
    func getItemInSection(_ indexPath: IndexPath) -> ProductItemType
    func updateSelectableItemState(at indexPath: IndexPath)
    func updateAdditionalItemStepper(action: StepperActionType, indexPath: IndexPath)
    func updateFooterStepper(with action: StepperActionType)
    func fetchProductDetails()
}
    

protocol ProductItemCellDelegate: AnyObject {
    func productItemCell(_ cell: QuantitativeItemCell, didTapStepperWithAction action: StepperActionType, at indexPath: IndexPath)
}


protocol ProductQuantityFooterViewDelegate: AnyObject {
    func stepperDidChange(_ footer: ProductPriceFooter, action: StepperActionType)
}
