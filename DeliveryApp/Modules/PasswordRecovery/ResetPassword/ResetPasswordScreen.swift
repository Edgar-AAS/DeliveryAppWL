//
//  ResetPasswordScreen.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 06/06/24.
//

import UIKit

class ResetPasswordScreen: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let resetPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reset Password"
        label.font = UIFont(name: "Inter-SemiBold", size: 32)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var resetPasswordDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your new password must be different from the previously used password"
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor(hexString: "878787")
        return label
    }()
    
    private let newPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "New Password"
        label.textColor = .black
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    lazy var newPasswordField: CustomTextField = {
        let textField = CustomTextField(exampleText: "New Password", isPassword: true, fieldType: .password)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .asciiCapable
        return textField
    }()
    
    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Confirm Password"
        label.textColor = .black
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    lazy var confirmPasswordField: CustomTextField = {
        let textField = CustomTextField(exampleText: "Confirm Password", isPassword: true, fieldType: .password)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .asciiCapable
        return textField
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Verify Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Bold", size: 14)
        button.backgroundColor = .black
        button.layer.cornerRadius = 26
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 4
        return button
    }()
}

extension ResetPasswordScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(resetPasswordLabel)
        containerView.addSubview(resetPasswordDescriptionLabel)
        containerView.addSubview(newPasswordLabel)
        containerView.addSubview(newPasswordField)
        containerView.addSubview(confirmPasswordLabel)
        containerView.addSubview(confirmPasswordField)
        containerView.addSubview(continueButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            resetPasswordLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            resetPasswordLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            resetPasswordLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            resetPasswordDescriptionLabel.topAnchor.constraint(equalTo: resetPasswordLabel.bottomAnchor, constant: 8),
            resetPasswordDescriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            resetPasswordDescriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            newPasswordLabel.topAnchor.constraint(equalTo: resetPasswordDescriptionLabel.bottomAnchor, constant: 24),
            newPasswordLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            newPasswordLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            newPasswordField.topAnchor.constraint(equalTo: newPasswordLabel.bottomAnchor, constant: 8),
            newPasswordField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            newPasswordField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            newPasswordField.heightAnchor.constraint(equalToConstant: 52),
            
            confirmPasswordLabel.topAnchor.constraint(equalTo: newPasswordField.bottomAnchor, constant: 24),
            confirmPasswordLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            confirmPasswordLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            confirmPasswordField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 8),
            confirmPasswordField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            confirmPasswordField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            confirmPasswordField.heightAnchor.constraint(equalToConstant: 52),
            
            continueButton.topAnchor.constraint(equalTo: confirmPasswordField.bottomAnchor, constant: 60),
            continueButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            continueButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            continueButton.heightAnchor.constraint(equalToConstant: 52),
            continueButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
