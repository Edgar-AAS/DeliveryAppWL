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

    init(delegate: CheckBoxDelegate?) {
        self.delegate = delegate
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        let normalImage = UIImage(named: "square-logo")?.resized(to: .init(width: 30, height: 30))
        let selectedImage = UIImage(named: "checkmark-logo")?.resized(to: .init(width: 30, height: 30))
        
        setImage(normalImage, for: .normal)
        setImage(selectedImage, for: .selected)
        
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            addTouchFeedback(style: .rigid)
            isChecked = !isChecked
        }
        addAction(action, for: .touchUpInside)
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


