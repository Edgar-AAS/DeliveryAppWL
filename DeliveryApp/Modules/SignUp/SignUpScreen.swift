//
//  SignUpScreen.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 26/01/24.
//

import UIKit

protocol SignUpScreenDelegateProtocol: AnyObject {
    func goToLoginButtonDidTapped()
    func loginWithGoogleButtonDidTapped()
    func registerButtonDidTapped()
}

final class SignUpScreen: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: SignUpScreenDelegateProtocol?

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
    
    private let createNewAccountHeadlineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create your new account"
        label.font = Fonts.semiBold(size: 32).weight
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private let createAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create an account to start looking for the food you like"
        label.font = Fonts.medium(size: 14).weight
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = Colors.descriptionTextColor
        return label
    }()
    
    private let emailAdressLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email Address"
        label.font = Fonts.medium(size: 14).weight
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
        label.font = Fonts.medium(size: 14).weight
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
        label.font = Fonts.medium(size: 14).weight
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
        label.font = Fonts.medium(size: 14).weight
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
        label.font = Fonts.medium(size: 14).weight
        
        let text = "I Agree with Terms of Service and Privacy Policy"
        let attributedText = NSMutableAttributedString(string: text)
        
        let termsOfServiceRange = (text as NSString).range(of: "Terms of Service")
        let privacyPolicyRange = (text as NSString).range(of: "Privacy Policy")
        
        if termsOfServiceRange.location != NSNotFound {
            attributedText.addAttribute(.foregroundColor, value: Colors.primaryColor, range: termsOfServiceRange)
        }
        
        if privacyPolicyRange.location != NSNotFound {
            attributedText.addAttribute(.foregroundColor, value: Colors.primaryColor, range: privacyPolicyRange)
        }
        
        label.attributedText = attributedText
        return label
    }()
    
    
    
    lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Fonts.semiBold(size: 14).weight
        button.backgroundColor = Colors.primaryColor
        button.layer.cornerRadius = 26
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 4
        
        let action = UIAction { [weak self] _ in
            self?.delegate?.registerButtonDidTapped()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private let orSignInWithLabel: UILabel = {
        let label = UILabel()
        label.text = "Or Login with"
        label.textColor = Colors.descriptionTextColor
        label.font = Fonts.medium(size: 14).weight
        label.textAlignment = .center
        return label
    }()
    
    private lazy var separatorStackView = makeStackView(with: [makeSeparatorView(color: Colors.descriptionTextColor),
                                                               orSignInWithLabel,
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
    
    private let alreadyHaveAccountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byClipping
        label.text = "Already have an account?"
        label.textColor = .black
        label.font = Fonts.medium(size: 14).weight
        return label
    }()
    
    private lazy var goToLoginButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login here", for: .normal)
        button.setTitleColor(Colors.primaryColor, for: .normal)
        button.titleLabel?.font = Fonts.semiBold(size: 14).weight
        
        let action = UIAction { [weak self] _ in
            self?.delegate?.goToLoginButtonDidTapped()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private lazy var loginStack = makeStackView(with: [alreadyHaveAccountLabel,
                                                       goToLoginButton],
                                                   aligment: .center,
                                                   spacing: 2,
                                                   axis: .horizontal)

    
    
    func setupButtonsDelegate(delegate: SignUpScreenDelegateProtocol) {
        self.delegate = delegate
    }
    
    func setupCheckBoxDelegate(delegate: CheckBoxDelegate) {
        checkBox.delegate = delegate
    }
    
    func setupTextFieldsDelegate(delegate: UITextFieldDelegate) {
        emailTextField.delegate = delegate
        userNameTextField.delegate = delegate
        passwordTextField.delegate = delegate
        passwordConfirmTextField.delegate = delegate
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        loginWithGoogleButton.makeCornerRadius()
        registerButton.makeCornerRadius()
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
        containerView.addSubview(loginWithGoogleButton)
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
            
            loginWithGoogleButton.topAnchor.constraint(equalTo: separatorStackView.bottomAnchor, constant: 16),
            loginWithGoogleButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            loginWithGoogleButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            loginWithGoogleButton.heightAnchor.constraint(equalToConstant: 52),
            
            loginStack.topAnchor.constraint(equalTo: loginWithGoogleButton.bottomAnchor, constant: 16),
            loginStack.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            loginStack.heightAnchor.constraint(equalToConstant: 44),
            loginStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
}
