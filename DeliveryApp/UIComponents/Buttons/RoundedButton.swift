import UIKit

final class RoundedButton: UIButton {
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
            guard let self else { return }
            self.completionHandler()
        }
        addAction(action, for: .touchUpInside)
    }
}
