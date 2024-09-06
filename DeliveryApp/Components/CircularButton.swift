import UIKit

final class CircularButton: UIButton {
    private let size: CGFloat
    private let iconImage: UIImage?
    
    init(iconImage: UIImage?, size: CGFloat) {
        self.size = size
        self.iconImage = iconImage
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        setImage(iconImage, for: .normal)
        heightAnchor.constraint(equalToConstant: size).isActive = true
        widthAnchor.constraint(equalToConstant: size).isActive = true
        layer.cornerRadius = size / 2
        layer.masksToBounds = true
    }
}
