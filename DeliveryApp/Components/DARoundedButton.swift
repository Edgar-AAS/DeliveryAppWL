import UIKit

final class DARoundedButton: UIButton {
    private let title: String?
    private let titleColor: UIColor
    private let color: UIColor
    private let image: UIImage?
    private var completionHandler: (() -> Void)
    
    init(title: String?,
         titleColor: UIColor,
         backgroundColor: UIColor,
         icon: UIImage?,
         action: @escaping (() -> Void)
    ) {
        self.title = title
        self.titleColor = titleColor
        self.color = backgroundColor
        self.image = icon
        self.completionHandler = action
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
        addTouchAnimation()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
    }
    
    private func setup() {
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        titleLabel?.font = Fonts.semiBold(size: 14).weight
        backgroundColor = color
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 4
        
        if image != nil {
            setImage(image, for: .normal)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        }
        
        let action = UIAction { [weak self] _ in
            guard let self = self else { return }
            self.completionHandler()
        }
        
        addAction(action, for: .touchUpInside)
    }
    
    private func addTouchAnimation() {
        addTarget(self, action: #selector(handleTouchDown), for: .touchDown)
        addTarget(self, action: #selector(handleTouchUpInside), for: .touchUpInside)
        addTarget(self, action: #selector(handleTouchUpOutside), for: .touchUpOutside)
    }
    
    @objc private func handleTouchDown() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
    }
    
    @objc private func handleTouchUpInside() {
        animateRelease()
    }
    
    @objc private func handleTouchUpOutside() {
        animateRelease()
    }
    
    private func animateRelease() {
        UIView.animate(withDuration: 0.1, animations: {
            self.transform = CGAffineTransform.identity
        })
    }
}
