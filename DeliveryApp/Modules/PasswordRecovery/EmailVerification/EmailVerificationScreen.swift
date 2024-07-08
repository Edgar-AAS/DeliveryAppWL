//
//  EmailVerificationScreen.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 21/05/24.
//

import UIKit



class EmailVerificationScreen: UIView {
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
    
    private let emailVerificationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email verification"
        label.font = UIFont(name: "Inter-SemiBold", size: 32)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var emailVerificationDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter the verification code we send you on: "
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = UIColor(hexString: "878787")
        return label
    }()
    
    lazy var receiveCodeTextField1: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 75).isActive = true
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.tintColor = .black
        textField.layer.cornerRadius = 12
        textField.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        textField.becomeFirstResponder()
        return textField
    }()
    
    lazy var receiveCodeTextField2: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 75).isActive = true
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.tintColor = .black
        textField.layer.cornerRadius = 12
        textField.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var receiveCodeTextField3: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 75).isActive = true
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.tintColor = .black
        textField.layer.cornerRadius = 12
        textField.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        return textField
    }()
    
    lazy var receiveCodeTextField4: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 75).isActive = true
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.tintColor = .black
        textField.layer.cornerRadius = 12
        textField.font = UIFont.systemFont(ofSize: 32, weight: .regular)
        textField.keyboardType = .numberPad
        textField.textAlignment = .center
        return textField
    }()
    
    private let codePromptLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Didn’t receive code?"
        label.textColor = UIColor(hexString: "878787")
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var resendCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Resend", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return button
    }()
    
    private lazy var receiveCodeStackView = makeStackView(with: [receiveCodeTextField1,
                                                                 receiveCodeTextField2,
                                                                 receiveCodeTextField3,
                                                                 receiveCodeTextField4],
                                                          distribution: .fillEqually,
                                                          spacing: 12,
                                                          axis: .horizontal)
    
    
    private lazy var resendStackView = makeStackView(with: [codePromptLabel,
                                                            resendCodeButton],
                                                     spacing: 2,
                                                     axis: .horizontal)
    
    private let clockImage: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "clock"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.tintColor = UIColor(hexString: "878787")
        return image
    }()
    
    lazy var cowntdownLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(hexString: "878787")
        return label
    }()
    
    private lazy var countdownStackView = makeStackView(with: [clockImage, cowntdownLabel],
                                                        aligment: .center,
                                                        spacing: 8,
                                                        axis: .horizontal)
    
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue", for: .normal)
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
    
    func disableResendButton() {
        resendCodeButton.setTitleColor(.lightGray, for: .normal)
        resendCodeButton.isEnabled = false
    }
    
    func enableResendButton() {
        resendCodeButton.setTitleColor(.orange, for: .normal)
        resendCodeButton.isEnabled = true
    }
    
    func setupTextFieldsDelegate(delegate: UITextFieldDelegate) {
        receiveCodeTextField1.delegate = delegate
        receiveCodeTextField2.delegate = delegate
        receiveCodeTextField3.delegate = delegate
        receiveCodeTextField4.delegate = delegate
    }
    
    func appendEmail(email: String) {
        emailVerificationDescriptionLabel.text?.append(email)
    }
}

extension EmailVerificationScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(emailVerificationLabel)
        containerView.addSubview(emailVerificationDescriptionLabel)
        containerView.addSubview(receiveCodeStackView)
        containerView.addSubview(resendStackView)
        containerView.addSubview(countdownStackView)
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
            
            emailVerificationLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 24),
            emailVerificationLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            emailVerificationLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            emailVerificationDescriptionLabel.topAnchor.constraint(equalTo: emailVerificationLabel.bottomAnchor, constant: 8),
            emailVerificationDescriptionLabel.leadingAnchor.constraint(equalTo: emailVerificationLabel.leadingAnchor),
            emailVerificationDescriptionLabel.trailingAnchor.constraint(equalTo: emailVerificationLabel.trailingAnchor),
            
            receiveCodeStackView.topAnchor.constraint(equalTo: emailVerificationDescriptionLabel.bottomAnchor, constant: 32),
            receiveCodeStackView.leadingAnchor.constraint(equalTo: emailVerificationLabel.leadingAnchor),
            receiveCodeStackView.trailingAnchor.constraint(equalTo: emailVerificationLabel.trailingAnchor),
            
            resendStackView.topAnchor.constraint(equalTo: receiveCodeStackView.bottomAnchor, constant: 16),
            resendStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            countdownStackView.topAnchor.constraint(equalTo: resendStackView.bottomAnchor, constant: 40),
            countdownStackView.centerXAnchor.constraint(equalTo: resendStackView.centerXAnchor),
            
            continueButton.topAnchor.constraint(equalTo: countdownStackView.bottomAnchor, constant: 100),
            continueButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            continueButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            continueButton.heightAnchor.constraint(equalToConstant: 52),
            continueButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
