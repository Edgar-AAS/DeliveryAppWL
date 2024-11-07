import UIKit

final class CustomSearchTextField: UITextField {
    private let searchIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .gray
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init(placeholder: String) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        borderStyle = .none
        layer.cornerRadius = 16
        backgroundColor = UIColor(white: 0.9, alpha: 0.6)
        tintColor = .black
        font = UIFont.systemFont(ofSize: 16)
        
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
