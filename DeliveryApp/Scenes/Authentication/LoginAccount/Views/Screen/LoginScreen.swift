import UIKit

final class LoginScreen: UIView {
    private lazy var loadingView = DALoadingView()
    weak var delegate: LoginScreenDelegate?
    weak var textFieldDelegate: UITextFieldDelegate?
    
    private var textFields: [DAFormTextField] {
        return [emailTextField, passwordTextField]
    }
    
    init(delegate: LoginScreenDelegate, textFieldDelegate: UITextFieldDelegate) {
        self.delegate = delegate
        self.textFieldDelegate = textFieldDelegate
        super.init(frame: .zero)
        setupView()
        hideKeyboardOnTap()
        setupKeyboardHandling(scrollView: customScrollView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var customScrollView = DAScrollView()
    
    private lazy var greetingLabel = makeLabel(
        text: "Welcome back",
        font: Fonts.semiBold(size: 32).weight,
        color: .darkGray,
        textAlignment: .center,
        numberOfLines: 0
    )
    
    private lazy var greetingDescriptionLabel = makeLabel(
        text: "Login to your account.",
        font: Fonts.medium(size: 16).weight,
        color: .darkGray,
        textAlignment: .center
    )
    
    private lazy var emailAdressLabel = makeLabel(
        text: "Email Address",
        font: Fonts.medium(size: 16).weight,
        color: .black,
        textAlignment: .left
    )
    
    private lazy var emailTextField = DAFormTextField(
        placeholder: "Enter Email",
        fieldType: "email",
        tag: 0,
        returnKeyType: .next,
        delegate: textFieldDelegate
    )
    
    private lazy var passwordTextField = DAFormTextField(
        placeholder: "Enter Password",
        fieldType: "password",
        tag: 1,
        returnKeyType: .done,
        delegate: textFieldDelegate
    )
    
    private lazy var passwordLabel = makeLabel(
        text: "Password",
        font: Fonts.medium(size: 16).weight,
        color: .black,
        textAlignment: .left
    )
    
    private lazy var forgotPasswordButton = DATitleButton(
        title: "Forgot password?",
        titleColor: .primary1,
        font: Fonts.medium(size: 14).weight,
        action: { [weak self] in
            guard let self else { return }
        }
    )
    
    private lazy var loginButton = DARoundedButton(
        title: "Log in",
        titleColor: .white,
        color: .primary1,
        icon: nil,
        action: { [weak self] in
            guard let self else { return }
            delegate?.signInButtonDidTapped(self)
        }
    )
    
    private lazy var signInOptionsLabel = makeLabel(
        text: "OR",
        font: Fonts.medium(size: 14).weight,
        color: .lightGray,
        textAlignment: .center
    )
    
    private lazy var dontHaveAccountLabel = makeLabel(
        text: "Don't have account?",
        font: Fonts.medium(size: 14).weight,
        color: .black
    )
    
    private lazy var registerButton: UIButton = {
        return DARoundedButton(
            title: "Register here",
            titleColor: .primary1,
            color: .white,
            icon: nil,
            action: { [weak self] in
                guard let self else { return }
                delegate?.registerButtonDidTapped(self)
            }
        )
    }()
    
    func goToNextField(_ textField: UITextField, action: (() -> Void)) {
        switch textField.tag {
        case 0:
            passwordTextField.becomeFirstResponder()
        case 1:
            action()
            passwordTextField.resignFirstResponder()
        default:
            return
        }
    }
        
    func getUserLoginRequest() -> LoginAccountRequest? {
        if let email = emailTextField.text,
           let password = passwordTextField.text {
            
            return LoginAccountRequest(email: email, password: password)
        } else {
            return nil
        }
    }
    
    func handleLoadingView(with state: Bool) {
        loadingView.handleLoading(with: state)
    }
}

extension LoginScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(customScrollView)
        addSubview(loadingView)
    
        customScrollView.addSubview(greetingLabel)
        customScrollView.addSubview(greetingDescriptionLabel)
        customScrollView.addSubview(emailAdressLabel)
        customScrollView.addSubview(emailTextField)
        customScrollView.addSubview(passwordLabel)
        customScrollView.addSubview(passwordTextField)
        customScrollView.addSubview(forgotPasswordButton)
        customScrollView.addSubview(loginButton)
        customScrollView.addSubview(signInOptionsLabel)
        customScrollView.addSubview(registerButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            customScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            customScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            greetingLabel.topAnchor.constraint(equalTo: customScrollView.container.topAnchor, constant: 36),
            greetingLabel.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            greetingLabel.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            
            greetingDescriptionLabel.topAnchor.constraint(equalTo: greetingLabel.bottomAnchor, constant: 8),
            greetingDescriptionLabel.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            greetingDescriptionLabel.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            
            emailAdressLabel.topAnchor.constraint(equalTo: greetingDescriptionLabel.bottomAnchor, constant: 80),
            emailAdressLabel.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            emailAdressLabel.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            
            emailTextField.topAnchor.constraint(equalTo: emailAdressLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            emailTextField.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            emailTextField.heightAnchor.constraint(equalToConstant: 52),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 32),
            passwordLabel.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            passwordLabel.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            passwordTextField.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            passwordTextField.heightAnchor.constraint(equalToConstant: 52),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            forgotPasswordButton.leadingAnchor.constraint(greaterThanOrEqualTo: customScrollView.container.leadingAnchor, constant: 24),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 44),
            
            loginButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 24),
            loginButton.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            loginButton.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            loginButton.heightAnchor.constraint(equalToConstant: 52),
            
            signInOptionsLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            signInOptionsLabel.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            signInOptionsLabel.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            
            registerButton.topAnchor.constraint(equalTo: signInOptionsLabel.bottomAnchor, constant: 16),
            registerButton.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            registerButton.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            registerButton.bottomAnchor.constraint(equalTo: customScrollView.container.bottomAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 52),
            
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    
    func setupAdditionalConfiguration() {
        backgroundColor = Colors.background
    }
}
