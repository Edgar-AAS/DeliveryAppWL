import UIKit

final class DASearchTextField: UITextField {
    private let searchIcon: UIImageView = {
        let searchIcon = UIImage(systemName: SFSymbols.search)
        let imageView = UIImageView(image: searchIcon)
        imageView.tintColor = .gray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        setup(placeholder: placeholder)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup(placeholder: String? = nil) {
        borderStyle = .none
        layer.cornerRadius = 16
        backgroundColor = UIColor(white: 0.9, alpha: 0.6)
        tintColor = .black
        textColor = .black
        font = UIFont.systemFont(ofSize: 16)
        self.placeholder = placeholder
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.lightGray,
            .font: Fonts.medium(size: 14).weight
        ]
        
        attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: frame.height))
        leftView = paddingView
        self.leftViewMode = .always
        
        let iconSize: CGFloat = 24
        searchIcon.frame = CGRect(x: 10, y: (frame.height - iconSize) / 2, width: iconSize, height: iconSize)
        paddingView.addSubview(searchIcon)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 10))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 10))
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 10))
    }
}
