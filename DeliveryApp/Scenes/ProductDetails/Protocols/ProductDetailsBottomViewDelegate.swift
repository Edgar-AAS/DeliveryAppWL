import Foundation

protocol ProductQuantityFooterViewDelegate: AnyObject {
    func productQuantityFooterView(_ footer: ProductQuantityFooterView, didTapStepperWithAction action: StepperActionType)
}
