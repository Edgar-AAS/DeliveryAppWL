//
//  LoginScreen.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 25/01/24.
//

import UIKit

protocol LoginScreenDelegateProtocol: AnyObject {
    func forgotPasswordButtonDidTapped()
    func signInButtonDidTapped()
    func loginWithGoogleButtonDidTapped()
    func registerButtonDidTapped()
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
        scrollView.backgroundColor = Colors.backgroundColor
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
        label.text = "Welcome back"
        label.font = Fonts.semiBold(size: 32).weight
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let signInLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login to your account."
        label.font = Fonts.medium(size: 16).weight
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = Colors.descriptionTextColor
        return label
    }()
    
    private let emailAdressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email Address"
        label.textColor = .black
        label.font = Fonts.medium(size: 16).weight
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
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Password"
        label.textColor = .black
        label.font = Fonts.medium(size: 16).weight
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
        button.setTitleColor(Colors.primaryColor, for: .normal)
        button.titleLabel?.font = Fonts.medium(size: 14).weight
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Fonts.semiBold(size: 14).weight
        button.backgroundColor = Colors.primaryColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        
        let action = UIAction { [weak self] _ in
            self?.delegate?.signInButtonDidTapped()
        }
        
        button.addAction(action, for: .touchUpInside)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 4
        return button
    }()
    
    private let signInOptionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Or Login with"
        label.textColor = Colors.descriptionTextColor
        label.font = Fonts.medium(size: 14).weight
        label.textAlignment = .center
        return label
    }()
    
    private lazy var separatorStackView = makeStackView(with: [makeSeparatorView(color: Colors.descriptionTextColor),
                                                               signInOptionsLabel,
                                                               makeSeparatorView(color: Colors.descriptionTextColor)],
                                                        aligment: .center,
                                                        distribution: .fillEqually,
                                                        spacing: 16,
                                                        axis: .horizontal)
    
    private lazy var loginWithGoogleButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "google-icon"), for: .normal)
        button.setTitle("Login with Google", for: .normal)
        button.titleLabel?.font = Fonts.medium(size: 14).weight
        button.layer.borderColor = Colors.grayBorderColor.cgColor
        button.setTitleColor(.black, for: .normal)
        button.layer.borderWidth = 1
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        
        let action = UIAction { [weak self] _ in
            self?.delegate?.loginWithGoogleButtonDidTapped()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private let dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Don't have account?"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.setTitleColor(Colors.primaryColor, for: .normal)
        button.titleLabel?.font = Fonts.semiBold(size: 14).weight
        
        let action = UIAction { [weak self] _ in
            self?.delegate?.registerButtonDidTapped()
        }
        button.addAction(action, for: .touchUpInside)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loginButton.makeCornerRadius()
        loginWithGoogleButton.makeCornerRadius()
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
        containerView.addSubview(loginButton)
        containerView.addSubview(separatorStackView)
        containerView.addSubview(loginWithGoogleButton)
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
            
            emailAdressLabel.topAnchor.constraint(equalTo: signInLabel.bottomAnchor, constant: 48),
            emailAdressLabel.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            emailAdressLabel.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailAdressLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 52),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 32),
            passwordLabel.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 52),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            forgotPasswordButton.leadingAnchor.constraint(greaterThanOrEqualTo: loginAccountHeadlineLabel.leadingAnchor),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 44),
            
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
            loginButton.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            
            separatorStackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 48),
            separatorStackView.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            separatorStackView.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            separatorStackView.heightAnchor.constraint(equalToConstant: 40),
            
            loginWithGoogleButton.topAnchor.constraint(equalTo: separatorStackView.bottomAnchor, constant: 16),
            loginWithGoogleButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            loginWithGoogleButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            loginWithGoogleButton.heightAnchor.constraint(equalToConstant: 52),
            
            registerStack.topAnchor.constraint(equalTo: loginWithGoogleButton.bottomAnchor, constant: 16),
            registerStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            registerStack.heightAnchor.constraint(equalToConstant: 44),
            registerStack.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor)
        ])
    }
}
