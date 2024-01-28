//
//  CircularButton.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 28/01/24.
//

import UIKit

final class CircularButton: UIButton {
    private let size: CGFloat
    private let icon: UIImage
    
    init(icon: UIImage, size: CGFloat) {
        self.size = size
        self.icon = icon
        super.init(frame: .zero)
        setup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.size.width / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 1
        contentMode = .scaleAspectFit
        layer.borderColor = UIColor(hexString: "D6D6D6").cgColor
        setImage(icon, for: .normal)
        layer.masksToBounds = true
        widthAnchor.constraint(equalToConstant: size).isActive = true
        heightAnchor.constraint(equalToConstant: size).isActive = true
    }
}
