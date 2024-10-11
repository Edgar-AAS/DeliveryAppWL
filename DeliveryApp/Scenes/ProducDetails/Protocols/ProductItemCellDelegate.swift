import Foundation

protocol ProductItemCellDelegate: AnyObject {
    func productItemCell(_ cell: ProductItemCell, didTapStepperWithAction action: StepperActionType, at indexPath: IndexPath)
}
