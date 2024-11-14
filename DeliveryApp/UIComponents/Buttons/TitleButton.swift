import UIKit

final class TitleButton: UIButton {
    private let title: String
    private let titleColor: UIColor
    private let font: UIFont
    private let background: UIColor?
    private let action: (() -> Void)
    
    init(title: String,
         titleColor: UIColor,
         font: UIFont,
         backgroundColor: UIColor? = .none,
         action: @escaping (() -> Void)) {
        self.title = title
        self.titleColor = titleColor
        self.font = font
        self.background = backgroundColor
        self.action = action
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
        addTouchAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = font
        backgroundColor = background
        
        addAction(UIAction(handler: { [weak self] _ in
            self?.action()
        }), for: .touchUpInside)
    }
    
    private func addTouchAnimation() {
        addTarget(self, action: #selector(handleTouchDown), for: .touchDown)
        addTarget(self, action: #selector(handleTouchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(handleTouchUpOutside), for: .touchUpOutside)
    }
    
    @objc private func handleTouchDown() {
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.setTitleColor(self?.titleColor.withAlphaComponent(0.5), for: .normal)
        }
    }
    
    @objc private func handleTouchUpInside() {
        animateRelease()
    }
    
    @objc private func handleTouchUpOutside() {
        animateRelease()
    }
    
    private func animateRelease() {
        UIView.animate(withDuration: 0.1) { [weak self] in
            self?.setTitleColor(self?.titleColor , for: .normal)
        }
    }
}
