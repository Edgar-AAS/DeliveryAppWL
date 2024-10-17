import Foundation

protocol ProductDetailsViewModelProtocol {
    func getNumberOfSections() -> Int
    func getNumberOfItemsBySection(_ section: Int) -> Int
    func getSectionName(_ section: Int) -> String
    func getSectionViewData(to section: Int) -> SectionHeaderViewData?
    func getItemInSection(_ indexPath: IndexPath) -> SectionType?
    func updateSideItemState(at indexPath: IndexPath)
    func updateAdditionalItemStepper(action: StepperActionType, indexPath: IndexPath)
    func updateFooterViewStepper(action: StepperActionType)
    func fetchProductDetails()
    func getStepperDto(in indexPath: IndexPath) -> StepperDTO?
}
    
