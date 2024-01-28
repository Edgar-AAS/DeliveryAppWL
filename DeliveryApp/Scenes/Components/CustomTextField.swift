//
//  CustomTextField.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 25/01/24.
//

import UIKit

final class CustomTextField: UITextField {
    private let exampleText: String
    private var padding: CGFloat = 20.0
    
    init(exampleText: String) {
        self.exampleText = exampleText
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(hexString: "D6D6D6").cgColor
        layer.cornerRadius = 8
        borderStyle = .roundedRect
        placeholder = exampleText
    }
    
    func addPaddingAndIcon(_ image: UIImage, padding: CGFloat) {
        let frame = CGRect(x: 0, y: 0, width: image.size.width + padding, height: image.size.height)
        
        let outerView = UIView(frame: frame)
        let iconView  = UIImageView(frame: frame)
        
        self.padding = iconView.frame.width + 10
        
        iconView.image = image
        iconView.tintColor = .black
        iconView.contentMode = .center
        outerView.addSubview(iconView)
        
        rightViewMode = .always
        rightView = outerView
      }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: 16, y: 0, width: bounds.width - padding, height: bounds.height)
        return bounds
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: 16, y: 0, width: bounds.width - padding, height: bounds.height)
        return bounds
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: 16, y: 0, width: bounds.width - padding, height: bounds.height)
        return bounds
    }
}
