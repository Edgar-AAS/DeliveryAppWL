import Foundation

protocol ProductDetailsViewModelDelegate: AnyObject {
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateHeaderWith viewData: ProductHeaderViewData)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didExceedOptionLimitInSection section: Int)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didChangeStepperValueAt indexPath: IndexPath)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didChangeBottomViewStepperValue stepperDto: StepperModel)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didSelectItemAt section: Int)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didEnableOptionsInSection section: Int)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateTotalAmount amount: ValueAnimateInfo)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateRequiredOptionsStatus status: OptionsStatusType)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, shouldEnableUserInteraction: Bool)
    func productDetailsViewModelDidUpdateUI(_ viewModel: ProductDetailsViewModel)
}


protocol ProductDetailsViewModelProtocol {
    func getNumberOfSections() -> Int
    func getNumberOfItemsBySection(_ section: Int) -> Int
    func getSectionViewData(to section: Int) -> SectionHeaderViewData?
    func getItemInSection(_ indexPath: IndexPath) -> SectionType?
    func updateSideItemState(at indexPath: IndexPath)
    func updateAdditionalItemStepper(action: StepperActionType, indexPath: IndexPath)
    func updateFooterViewStepper(action: StepperActionType)
    func fetchProductDetails()
    func getStepperDto(in indexPath: IndexPath) -> StepperModel?
}
    

protocol ProductItemCellDelegate: AnyObject {
    func productItemCell(_ cell: ProductItemCell, didTapStepperWithAction action: StepperActionType, at indexPath: IndexPath)
}


protocol ProductQuantityFooterViewDelegate: AnyObject {
    func productQuantityFooterView(_ footer: ProductQuantityFooterView, didTapStepperWithAction action: StepperActionType)
}
