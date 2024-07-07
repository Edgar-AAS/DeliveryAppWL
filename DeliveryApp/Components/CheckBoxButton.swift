import UIKit

protocol CheckBoxDelegate: AnyObject {
    func checkBoxDidChange(_ checkBox: CheckBoxButton, isChecked: Bool)
}

final class CheckBoxButton: UIButton {
    weak var delegate: CheckBoxDelegate?
    private var isChecked: Bool = false {
        didSet {
            isSelected = isChecked
            delegate?.checkBoxDidChange(self, isChecked: isChecked)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {
        let normalImage = UIImage(named: "square-logo")?.resized(to: .init(width: 30, height: 30))
        let selectedImage = UIImage(named: "checkmark-logo")?.resized(to: .init(width: 30, height: 30))
        
        setImage(normalImage, for: .normal)
        setImage(selectedImage, for: .selected)
        addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
    }

    @objc private func checkBoxTapped() {
        addTouchFeedback(style: .rigid)
        isChecked = !isChecked
    }
}

extension UIImage {
    func resized(to newSize: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: newSize))
        return UIGraphicsGetImageFromCurrentImageContext() ?? self
    }
}


