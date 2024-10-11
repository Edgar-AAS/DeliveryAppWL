import Foundation

protocol ProductDetailsViewModelDelegate: AnyObject {
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didUpdateHeaderWith viewData: HeaderViewData)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didExceedOptionLimitInSection section: Int)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didChangeStepperValueAt indexPath: IndexPath)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didSelectItemAt indexPath: IndexPath)
    func productDetailsViewModel(_ viewModel: ProductDetailsViewModel, didEnableOptionsInSection section: Int)
    func productDetailsViewModelDidUpdateUI(_ viewModel: ProductDetailsViewModel)
}
