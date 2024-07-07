//
//  LoginScreen.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 25/01/24.
//

import UIKit

enum LoginMethod {
    case googleAccount
    case facebookAccount
    case appleAccount
}

protocol LoginScreenDelegateProtocol: AnyObject {
    func alternativeLoginButtonDidTapped(loginMethod: LoginMethod)
    func forgotPasswordButtonDidTapped()
}

final class LoginScreen: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: LoginScreenDelegateProtocol?
    
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
    
    private let loginAccountHeadlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login to your account."
        label.font = UIFont(name: "Inter-SemiBold", size: 32)
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please sign in to your account"
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
        textField.tag = 0
        textField.autocapitalizationType = .none
        textField.returnKeyType = .next
        textField.autocorrectionType = .no
        textField.becomeFirstResponder()
        return textField
    }()
    
    private let passwordLabel: UILabel = {
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
        textField.tag = 1
        textField.keyboardType = .asciiCapable
        return textField
    }()
    
     private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot password?", for: .normal)
        button.addTarget(self, action: #selector(forgotPasswordTap), for: .touchUpInside)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 14)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign In", for: .normal)
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
    
    private let signInOptionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Or sign in with"
        label.textColor = UIColor(hexString: "878787")
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textAlignment = .center
        return label
    }()
    
    private lazy var separatorStackView = makeStackView(with: [makeSeparatorView(color: UIColor(hexString: "878787")),
                                                               signInOptionsLabel,
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
    
    lazy var loginWithFacebookButton: CircularButton = {
        let button = CircularButton(iconImage: UIImage(named: "facebook-button-icon"), size: 44)
        button.addTarget(self, action: #selector(alternativeLoginButtonTap), for: .touchUpInside)
        button.tag = 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        return button
    }()
    
    lazy var loginWithAppleButton: CircularButton = {
        let button = CircularButton(iconImage: UIImage(named: "apple-button-icon"), size: 44)
        button.tag = 3
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.addTarget(self,
                         action: #selector(alternativeLoginButtonTap),
                         for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonStack = makeStackView(with: [loginWithGoogleButton,
                                                        loginWithFacebookButton,
                                                        loginWithAppleButton],
                                                 aligment: .center,
                                                 spacing: 16,
                                                 axis: .horizontal)


    private let dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Don't have account?"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.orange, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14)
        return button
    }()
    
    private lazy var registerStack = makeStackView(with: [dontHaveAccountLabel,
                                                          registerButton],
                                                   aligment: .center,
                                                   spacing: 2,
                                                   axis: .horizontal)

    @objc func forgotPasswordTap() {
        delegate?.forgotPasswordButtonDidTapped()
    }
    
    
    @objc func alternativeLoginButtonTap(_ sender: UIButton) {
        let buttonType: LoginMethod
        
        switch sender.tag {
            case 1:
                buttonType = .googleAccount
            case 2:
                buttonType = .facebookAccount
            case 3:
                buttonType = .appleAccount
            default: return
        }
        delegate?.alternativeLoginButtonDidTapped(loginMethod: buttonType)
    }
}

extension LoginScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(loginAccountHeadlineLabel)
        containerView.addSubview(signInLabel)
        containerView.addSubview(emailAdressLabel)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordLabel)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(forgotPasswordButton)
        containerView.addSubview(signInButton)
        containerView.addSubview(separatorStackView)
        containerView.addSubview(buttonStack)
        containerView.addSubview(registerStack)
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
            
            loginAccountHeadlineLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            loginAccountHeadlineLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            loginAccountHeadlineLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            signInLabel.topAnchor.constraint(equalTo: loginAccountHeadlineLabel.bottomAnchor, constant: 8),
            signInLabel.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            signInLabel.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            
            emailAdressLabel.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 24),
            emailAdressLabel.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            emailAdressLabel.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailAdressLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 52),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 24),
            passwordLabel.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 52),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            forgotPasswordButton.leadingAnchor.constraint(greaterThanOrEqualTo: loginAccountHeadlineLabel.leadingAnchor),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            
            signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
            signInButton.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 52),
            
            separatorStackView.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 24),
            separatorStackView.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            separatorStackView.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            
            buttonStack.topAnchor.constraint(equalTo: separatorStackView.bottomAnchor, constant: 25),
            buttonStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            
            registerStack.topAnchor.constraint(equalTo: buttonStack.bottomAnchor, constant: 24),
            registerStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            registerStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
