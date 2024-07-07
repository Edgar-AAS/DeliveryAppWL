//
//  ForgotPasswordScreen.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 19/05/24.
//

import UIKit


protocol ForgotPasswordScreenDelegateProtocol: AnyObject {
    func continueButtonDidTapped()
}

class ForgotPasswordScreen: UIView {
    private weak var delegate: ForgotPasswordScreenDelegateProtocol?
    
    init(delegate: ForgotPasswordScreenDelegateProtocol) {
        self.delegate = delegate
        super.init(frame: .zero)
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
    
    private let forgotPasswordHeadlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Forgot password?"
        label.font = UIFont(name: "Inter-SemiBold", size: 32)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let forgotPasswordDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter your email address and we’ll send you confirmation code to reset your password"
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor(hexString: "878787")
        return label
    }()
    
    private let emailAdressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email Address"
        label.textColor = .black
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(exampleText: "Enter Email", fieldType: .email)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.becomeFirstResponder()
        return textField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(continueButtonTap), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "Inter-Bold", size: 14)
        button.backgroundColor = .black
        button.layer.cornerRadius = 26
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 4
        return button
    }()
    
    @objc func continueButtonTap() {
        delegate?.continueButtonDidTapped()
    }
}

extension ForgotPasswordScreen: CodeView {
    func buildViewHierarchy() {
       addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(forgotPasswordHeadlineLabel)
        containerView.addSubview(forgotPasswordDescriptionLabel)
        containerView.addSubview(emailAdressLabel)
        containerView.addSubview(emailTextField)
        containerView.addSubview(continueButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            forgotPasswordHeadlineLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            forgotPasswordHeadlineLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            forgotPasswordHeadlineLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            forgotPasswordDescriptionLabel.topAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.bottomAnchor, constant: 8),
            forgotPasswordDescriptionLabel.leadingAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.leadingAnchor),
            forgotPasswordDescriptionLabel.trailingAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.trailingAnchor),
            
            emailAdressLabel.topAnchor.constraint(equalTo: forgotPasswordDescriptionLabel.bottomAnchor, constant: 24),
            emailAdressLabel.leadingAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.leadingAnchor),
            emailAdressLabel.trailingAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailAdressLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 52),
            
            continueButton.topAnchor.constraint(lessThanOrEqualTo: emailTextField.bottomAnchor, constant: 200),
            continueButton.leadingAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.leadingAnchor, constant: 24),
            continueButton.trailingAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.trailingAnchor, constant: -24),
            continueButton.heightAnchor.constraint(equalToConstant: 52),
            continueButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
