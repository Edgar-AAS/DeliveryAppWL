import UIKit

protocol CheckBoxDelegate: AnyObject {
    func checkBoxDidChange(_ checkBox: DACheckBoxButton, isChecked: Bool)
}

final class DACheckBoxButton: UIButton {
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
        let normalImage = UIImage(named: Assets.Icons.checkBoxUnchecked)
        let selectedImage = UIImage(named: Assets.Icons.checkBoxChecked)
        
        setImage(normalImage, for: .normal)
        setImage(selectedImage, for: .selected)
        
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            addTouchFeedback(style: .light)
            isChecked = !isChecked
        }
        
        addAction(action, for: .touchUpInside)
    
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: centerXAnchor),
            centerYAnchor.constraint(equalTo: centerYAnchor),
            heightAnchor.constraint(equalToConstant: 30),
            widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
