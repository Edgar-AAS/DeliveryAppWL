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
    private let fieldType: FieldType
    
    private var isHide: Bool = true {
        didSet {
            hideAndShowPasswordButton.isSelected = !isHide
            isSecureTextEntry = isHide
        }
    }
    
    init(exampleText: String, isPassword: Bool = false, fieldType: FieldType = .regular) {
        self.exampleText = exampleText
        self.isPassword = isPassword
        self.fieldType = fieldType
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        layer.cornerRadius = 8
        backgroundColor = .white
        tintColor = .black
        borderStyle = .roundedRect
        placeholder = exampleText
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: attributes)
        self.attributedPlaceholder = attributedPlaceholder
        
        if isPassword {
            isSecureTextEntry = true
            let frame = CGRect(x: 0, y: 0, width: hideAndShowPasswordButton.frame.size.width + 10, height: hideAndShowPasswordButton.frame.size.height)
            let outerView = UIView(frame: frame)
            outerView.addSubview(hideAndShowPasswordButton)
            rightViewMode = .always
            rightView = outerView
        }
        
        addSubview(feedbackLabel)
        NSLayoutConstraint.activate([
            feedbackLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 4),
            feedbackLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            feedbackLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private lazy var feedbackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()
        
    private lazy var hideAndShowPasswordButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.frame.size = .init(width: 24, height: 24)
        button.tintColor = .black
        button.layoutIfNeeded()
        button.addTarget(self, action: #selector(eyeButtonTap), for: .touchUpInside)
        return button
    }()
    
    @objc func eyeButtonTap() {
        addTouchFeedback(style: .rigid)
        isHide = !isHide
    }
    
    func setDescriptionField(viewModel: FieldDescriptionViewModel) {
        if fieldType == viewModel.fieldType {
            feedbackLabel.isHidden = false
            feedbackLabel.text = viewModel.message
        } else {
            feedbackLabel.isHidden = true
        }
    }
}
