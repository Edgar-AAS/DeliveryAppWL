//
//  SignUpScreen.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 26/01/24.
//

import UIKit

final class SignUpScreen: UIView {
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
    
    private let createNewAccountHeadlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create your new account"
        label.font = UIFont(name: "Inter-SemiBold", size: 32)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let createAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create an account to start looking for the food you like"
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
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(exampleText: "Enter Email", fieldType: .email)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.becomeFirstResponder()
        textField.tag = 0
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.returnKeyType = .next
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "User Name"
        label.textColor = .black
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    lazy var userNameTextField: CustomTextField = {
        let textField = CustomTextField(exampleText: "Enter Name", fieldType: .regular)
        textField.returnKeyType = .next
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 1
        return textField
    }()
        
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password"
        label.textColor = .black
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(exampleText: "Enter Password", isPassword: true, fieldType: .password)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.returnKeyType = .next
        textField.tag = 2
        textField.keyboardType = .asciiCapable
        return textField
    }()
    
    private lazy var passwordConfirmLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password Confirm"
        label.textColor = .black
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    lazy var passwordConfirmTextField: CustomTextField = {
        let textField = CustomTextField(exampleText: "Password Confirm", isPassword: true, fieldType: .passwordConfirm)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tag = 3
        textField.keyboardType = .asciiCapable
        return textField
    }()
    
    private lazy var checkBox: CheckBoxButton = {
        let checkBox = CheckBoxButton()
        checkBox.translatesAutoresizingMaskIntoConstraints = false
        return checkBox
    }()

    
    private let termsOfServicLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.textColor = .black
        label.font = UIFont(name: "Inter-Medium", size: 14)
        let attributedText = NSMutableAttributedString(string: "I Agree with Terms of Service and Privacy Policy")
        
        let termsOfServiceRange = NSRange(location: 13, length: 16)
        let privacyPolicy = NSRange(location: 33, length: 15)
        
        attributedText.addAttribute(.foregroundColor, value: UIColor.orange, range: termsOfServiceRange)
        attributedText.addAttribute(.foregroundColor, value: UIColor.orange, range: privacyPolicy)
        
        label.attributedText = attributedText
        return label
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14)
        button.backgroundColor = .black
        button.layer.cornerRadius = 26
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 4
        return button
    }()
    
    private let orSignInWithLabel: UILabel = {
        let label = UILabel()
        label.text = "Or sign in with"
        label.textColor = UIColor(hexString: "878787")
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var separatorStackView = makeStackView(with: [makeSeparatorView(color: UIColor(hexString: "878787")),
                                                               orSignInWithLabel,
                                                               makeSeparatorView(color: UIColor(hexString: "878787"))],
                                                        aligment: .center,
                                                        distribution: .fillEqually,
                                                        spacing: 16,
                                                        axis: .horizontal)
    
    lazy var loginWithGoogleButton: CircularButton = {
        let button = CircularButton(iconImage: UIImage(named: "google-button-icon"), size: 44)
        button.tag = 1
        button.addTarget(self, action: #selector(alternativeLoginButtonTap), for: .touchUpInside)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    private lazy var loginWithFacebookButton: CircularButton = {
        let button = CircularButton(iconImage: UIImage(named: "facebook-button-icon"), size: 44)
        button.addTarget(self, action: #selector(alternativeLoginButtonTap), for: .touchUpInside)
        button.tag = 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    private lazy var loginWithAppleButton: CircularButton = {
        let button = CircularButton(iconImage: UIImage(named: "apple-button-icon"), size: 44)
        button.tag = 3
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self,
                         action: #selector(alternativeLoginButtonTap),
                         for: .touchUpInside)
        return button
    }()
    
    @objc func alternativeLoginButtonTap(_ sender: UIButton) {
        let loginMethod: LoginMethod
        
        switch sender.tag {
        case 1:
            loginMethod = .googleAccount
        case 2:
            loginMethod = .facebookAccount
        case 3:
            loginMethod = .appleAccount
        default: return
        }
        
//        delegate?.alternativeLoginButtonDidTapped(loginMethod: loginMethod)
    }
    
    private lazy var buttonStack = makeStackView(with: [loginWithGoogleButton,
                                                        loginWithFacebookButton,
                                                        loginWithAppleButton],
                                                 aligment: .center,
                                                 spacing: 16,
                                                 axis: .horizontal)

    private let alreadyHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.text = "Already have an account?"
        label.textColor = .black
        label.font = UIFont(name: "Inter-Medium", size: 14)
        return label
    }()
    
    lazy var loginHereButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login here", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14)
        return button
    }()
    
    private lazy var loginStack = makeStackView(with: [alreadyHaveAccountLabel,
                                                       loginHereButton],
                                                   aligment: .center,
                                                   spacing: 2,
                                                   axis: .horizontal)

    func setupCheckBoxDelegate(delegate: CheckBoxDelegate) {
        checkBox.delegate = delegate
    }
    
    func setupTextFieldsDelegate(delegate: UITextFieldDelegate) {
        emailTextField.delegate = delegate
        userNameTextField.delegate = delegate
        passwordTextField.delegate = delegate
        passwordConfirmTextField.delegate = delegate
    }
}

extension SignUpScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(createNewAccountHeadlineLabel)
        containerView.addSubview(createAccountLabel)
        containerView.addSubview(emailAdressLabel)
        containerView.addSubview(emailTextField)
        containerView.addSubview(userNameLabel)
        containerView.addSubview(userNameTextField)
        containerView.addSubview(passwordLabel)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(passwordConfirmLabel)
        containerView.addSubview(passwordConfirmTextField)
        containerView.addSubview(checkBox)
        containerView.addSubview(termsOfServicLabel)
        containerView.addSubview(registerButton)
        containerView.addSubview(separatorStackView)
        containerView.addSubview(buttonStack)
        containerView.addSubview(loginStack)
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
            
            createNewAccountHeadlineLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            createNewAccountHeadlineLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            createNewAccountHeadlineLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            createAccountLabel.topAnchor.constraint(equalTo: createNewAccountHeadlineLabel.bottomAnchor, constant: 8),
            createAccountLabel.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            createAccountLabel.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            
            emailAdressLabel.topAnchor.constraint(equalTo: createAccountLabel.bottomAnchor, constant: 24),
            emailAdressLabel.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            emailAdressLabel.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailAdressLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 52),
            
            userNameLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
            userNameLabel.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            
            userNameTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            userNameTextField.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            userNameTextField.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: 52),
            
            passwordLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 24),
            passwordLabel.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 52),
            
            passwordConfirmLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            passwordConfirmLabel.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            passwordConfirmLabel.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            
            passwordConfirmTextField.topAnchor.constraint(equalTo: passwordConfirmLabel.bottomAnchor, constant: 8),
            passwordConfirmTextField.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            passwordConfirmTextField.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            passwordConfirmTextField.heightAnchor.constraint(equalToConstant: 52),
            
            checkBox.topAnchor.constraint(equalTo: passwordConfirmTextField.bottomAnchor, constant: 30),
            checkBox.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            
            termsOfServicLabel.centerYAnchor.constraint(equalTo: checkBox.centerYAnchor),
            termsOfServicLabel.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 8),
            termsOfServicLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -18),
            
            registerButton.topAnchor.constraint(equalTo: termsOfServicLabel.bottomAnchor, constant: 24),
            registerButton.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 52),
            
            separatorStackView.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 24),
            separatorStackView.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            separatorStackView.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            
            buttonStack.topAnchor.constraint(equalTo: separatorStackView.bottomAnchor, constant: 24),
            buttonStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
        
            loginStack.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 32),
            loginStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            loginStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
