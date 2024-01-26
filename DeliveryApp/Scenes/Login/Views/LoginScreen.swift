//
//  LoginScreen.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 25/01/24.
//

import UIKit

final class LoginScreen: UIView {
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
    
    
    private let loginAccountHeadlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Login to your account."
        label.font = UIFont(name: "Inter-SemiBold", size: 32)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let signInOrSignUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please sign in to your account"
        label.font = UIFont(name: "Inter-Medium", size: 14)
        label.textAlignment = .left
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
    
    private lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(exampleText: "Enter Email")
        textField.keyboardType = .emailAddress
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
    
    private lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(exampleText: "Password")
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let forgotPasswordButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 14)
        button.contentHorizontalAlignment = .right
        return button
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14)
        button.backgroundColor = .systemBlue
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
    
    
    private lazy var signInMethodButton1 = makeLoginMethodButton()
    private lazy var signInMethodButton2 = makeLoginMethodButton()
    private lazy var signInMethodButton3 = makeLoginMethodButton()
    
    private lazy var separatorStackView = makeStackView(with: [makeSeparatorView(color: UIColor(hexString: "878787")),
                                                               orSignInWithLabel,
                                                               makeSeparatorView(color: UIColor(hexString: "878787"))],
                                                        aligment: .center,
                                                        distribution: .fillEqually,
                                                        spacing: 16,
                                                        axis: .horizontal)
    
    private lazy var buttonsStack = makeStackView(with: [signInMethodButton1,
                                                         signInMethodButton2,
                                                         signInMethodButton3],
                                                  aligment: .center,
                                                  distribution: .equalSpacing,
                                                  spacing: 16,
                                                  axis: .horizontal)
    
    
    private let dontHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Don't have account?"
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14)
        return button
    }()
    
    private lazy var registerStack = makeStackView(with: [dontHaveAccountLabel, registerButton],
                                                   aligment: .center,
                                                   spacing: 2,
                                                   axis: .horizontal)
    
    
    
    func makeLoginMethodButton() -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(hexString: "D6D6D6").cgColor
        button.layer.cornerRadius = 20
        button.setImage(UIImage(named: "apple-logo"), for: .normal)
        button.clipsToBounds = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }
}

extension LoginScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(loginAccountHeadlineLabel)
        containerView.addSubview(signInOrSignUpLabel)
        containerView.addSubview(emailAdressLabel)
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordLabel)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(forgotPasswordButton)
        containerView.addSubview(signInButton)
        containerView.addSubview(separatorStackView)
        containerView.addSubview(buttonsStack)
        containerView.addSubview(registerStack)
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
            
            loginAccountHeadlineLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 32),
            loginAccountHeadlineLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            loginAccountHeadlineLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            signInOrSignUpLabel.topAnchor.constraint(equalTo: loginAccountHeadlineLabel.bottomAnchor, constant: 8),
            signInOrSignUpLabel.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            signInOrSignUpLabel.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            
            emailAdressLabel.topAnchor.constraint(equalTo: signInOrSignUpLabel.bottomAnchor, constant: 32),
            emailAdressLabel.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            emailAdressLabel.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailAdressLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 52),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 14),
            passwordLabel.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            passwordLabel.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 52),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 24),
            forgotPasswordButton.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            
            signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
            signInButton.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 52),
            
            separatorStackView.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 24),
            separatorStackView.leadingAnchor.constraint(equalTo: loginAccountHeadlineLabel.leadingAnchor),
            separatorStackView.trailingAnchor.constraint(equalTo: loginAccountHeadlineLabel.trailingAnchor),
            
            buttonsStack.topAnchor.constraint(equalTo: separatorStackView.bottomAnchor, constant: 25),
            buttonsStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            buttonsStack.widthAnchor.constraint(equalToConstant: 152),
            buttonsStack.heightAnchor.constraint(equalToConstant: 40),
            
            registerStack.topAnchor.constraint(equalTo: buttonsStack.bottomAnchor, constant: 34),
            registerStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            registerStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    func setupAddiotionalConfiguration() {
        passwordTextField.addPaddingAndIcon(UIImage(systemName: "eye.slash")!, padding: 16.0)
    }
}
