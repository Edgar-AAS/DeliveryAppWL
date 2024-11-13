import UIKit

final class CircularButton: UIButton {
    private let size: CGFloat
    private let iconImage: UIImage?
    private let tint: UIColor
    private let background: UIColor
    private let onTap: (() -> Void)
    
    init(iconImage: UIImage?, size: CGFloat, tint: UIColor = .black, backgroundColor: UIColor = .white, onTap: @escaping (() -> Void)) {
        self.size = size
        self.iconImage = iconImage
        self.tint = tint
        self.background = backgroundColor
        self.onTap = onTap
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
            self?.onTap()
        })
        
        addAction(tapAction, for: .touchUpInside)
    }
}
