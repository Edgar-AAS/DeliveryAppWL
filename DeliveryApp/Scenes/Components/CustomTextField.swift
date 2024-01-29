//
//  CustomTextField.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 25/01/24.
//

import UIKit

final class CustomTextField: UITextField {
    private let exampleText: String
    private let isPassword: Bool
    
    private var isHide: Bool = true {
        didSet {
            hideAndShowPasswordButton.isSelected = !isHide
            isSecureTextEntry = isHide
        }
    }
    
    init(exampleText: String, isPassword: Bool = false) {
        self.exampleText = exampleText
        self.isPassword = isPassword
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var hideAndShowPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.frame.size = .init(width: 24, height: 24)
        button.tintColor = .black
        button.addTarget(self, action: #selector(eyeButtonTap), for: .touchUpInside)
        return button
    }()
    
    @objc func eyeButtonTap() {
        isHide = !isHide
    }
    
    private func setup() {
        layer.borderWidth = 1
        layer.borderColor = UIColor(hexString: "D6D6D6").cgColor
        layer.cornerRadius = 8
        clipsToBounds = true
        borderStyle = .roundedRect
        placeholder = exampleText
        
        if isPassword {
            isSecureTextEntry = true
            let frame = CGRect(x: 0, y: 0, width: hideAndShowPasswordButton.frame.size.width + 10, height: hideAndShowPasswordButton.frame.size.height)
            let outerView = UIView(frame: frame)
            outerView.addSubview(hideAndShowPasswordButton)
            rightViewMode = .always
            rightView = outerView
        }
    }
}
