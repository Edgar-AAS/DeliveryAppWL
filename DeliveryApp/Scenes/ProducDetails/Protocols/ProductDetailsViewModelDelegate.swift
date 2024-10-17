import Foundation

protocol ProductDetailsViewModelDelegate: AnyObject {
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateHeaderWith viewData: HeaderViewData)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didExceedOptionLimitInSection section: Int)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didChangeStepperValueAt indexPath: IndexPath)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didChangeBottomViewStepperValue stepperDto: StepperDTO)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didSelectItemAt section: Int)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didEnableOptionsInSection section: Int)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateTotalAmount amount: ValueAnimateInfo)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateRequiredOptionsStatus status: OptionsStatusType)
    func productDetailsViewModelDidUpdateUI(_ viewModel: ProductDetailsViewModel)
}
