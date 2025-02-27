import UIKit

final class DARoundedButton: UIButton {
    private let title: String?
    private let titleColor: UIColor
    private let color: UIColor
    private let font: UIFont
    private let image: UIImage?
    private var completionHandler: (() -> Void)
    
    init(title: String? = "",
         font: UIFont = .systemFont(ofSize: 14),
         titleColor: UIColor = .black,
         color: UIColor = .white,
         icon: UIImage? = nil,
         action: @escaping (() -> Void))
    {
        self.title = title
        self.titleColor = titleColor
        self.color = color
        self.image = icon
        self.completionHandler = action
        self.font = font
        
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        setTitle(title, for: .normal)
        setTitleColor(titleColor, for: .normal)
        backgroundColor = color
        titleLabel?.font = font
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 4
        
        if let image = icon {
            setImage(image, for: .normal)
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        }
        
        let action = UIAction { [weak self] _ in
            self?.completionHandler()
        }
        addAction(action, for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 12
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
