import Foundation

protocol ProductDetailsBottomViewDelegate: AnyObject {
    func productDetailsBottomView(_ view: ProductDetailsBottomView, didTapStepperWithAction action: StepperActionType)
}
