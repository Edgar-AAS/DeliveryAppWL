import UIKit

final class DACircularButton: UIButton {
    private let size: CGFloat
    private let iconImage: UIImage?
    private let tint: UIColor
    private let background: UIColor
    private let action: (() -> Void)
    
    init(iconImage: UIImage?,
         size: CGFloat,
         tint: UIColor = .black,
         backgroundColor: UIColor = .white,
         onTap: @escaping (() -> Void)
    ) {
        self.size = size
        self.iconImage = iconImage
        self.tint = tint
        self.background = backgroundColor
        self.action = onTap
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = tint
        backgroundColor = background
        setImage(iconImage, for: .normal)
        heightAnchor.constraint(equalToConstant: size).isActive = true
        widthAnchor.constraint(equalToConstant: size).isActive = true
        layer.cornerRadius = size / 2
        layer.masksToBounds = true
        
        let tapAction =  UIAction(handler: { [weak self] _ in
            self?.action()
        })
        
        addAction(tapAction, for: .touchUpInside)
    }
}
