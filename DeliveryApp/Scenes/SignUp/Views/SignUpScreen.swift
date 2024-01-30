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
        label.textAlignment = .left
        return label
    }()
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(exampleText: "Enter Email")
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "User Name"
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    lazy var userNameTextField: CustomTextField = {
        let textField = CustomTextField(exampleText: "User Name")
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
        
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password"
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textAlignment = .left
        return label
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(exampleText: "Password", isPassword: true)
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    private lazy var loginMethodButton1 = CircularButton(icon: UIImage(named: "google-logo")!, size: 40)
    private lazy var loginMethodButton2 = CircularButton(icon: UIImage(named: "facebook-logo")!, size: 40)
    private lazy var loginMethodButton3 = CircularButton(icon: UIImage(named: "apple-logo")!, size: 40)
    
    private lazy var buttonStack = makeButtonStack(buttons: [
        loginMethodButton1,
        loginMethodButton2,
        loginMethodButton3
    ])
    
    private let alreadyHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.text = "Already have an account?"
        label.font = UIFont(name: "Inter-Medium", size: 14)
        return label
    }()
    
    private lazy var loginHereButton: UIButton = {
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
        containerView.addSubview(checkBox)
        containerView.addSubview(termsOfServicLabel)
        containerView.addSubview(registerButton)
        containerView.addSubview(separatorStackView)
        containerView.addSubview(buttonStack)
        containerView.addSubview(loginStack)
    }
    
    func setupConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),    
            
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            createNewAccountHeadlineLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
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
            
            userNameLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 14),
            userNameLabel.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            
            userNameTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            userNameTextField.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            userNameTextField.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            userNameTextField.heightAnchor.constraint(equalToConstant: 52),
            
            passwordLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 14),
            passwordLabel.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 52),
            
            checkBox.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 14),
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
