import UIKit

final class LoginScreen: UIView {
    weak var delegate: LoginScreenDelegate?
    weak var textFieldDelegate: UITextFieldDelegate?
    
    init(delegate: LoginScreenDelegate, textFieldDelegate: UITextFieldDelegate) {
        self.delegate = delegate
        self.textFieldDelegate = textFieldDelegate
        super.init(frame: .zero)
        setupView()
        hideKeyboardOnTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var customScrollView: CustomScrollView = {
        let scrollView = CustomScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var loginAccountHeadlineLabel = makeLabel(
        text: "Welcome back",
        font: Fonts.semiBold(size: 32).weight,
        color: .black,
        textAlignment: .center
    )
    
    private lazy var signInLabel = makeLabel(
        text: "Login to your account.",
        font: Fonts.medium(size: 16).weight,
        color: Colors.descriptionTextColor,
        textAlignment: .center
    )
    
    private lazy var emailAdressLabel = makeLabel(
        text: "Email Address",
        font: Fonts.medium(size: 16).weight,
        color: .black,
        textAlignment: .left
    )
    
    lazy var emailTextField = CustomTextField(
        placeholder: "Enter Email",
        fieldType: .email,
        tag: 0,
        returnKeyType: .next,
        delegate: textFieldDelegate
    )
    
    lazy var passwordTextField = CustomTextField(
        placeholder: "Enter Password",
        fieldType: .password,
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
    
    private lazy var forgotPasswordButton = makeButton(
        title: "Forgot password?",
        titleColor: Colors.primaryColor,
        font: Fonts.medium(size: 14).weight,
        action: UIAction { [weak self] _ in
            self?.delegate?.forgotPasswordButtonDidTapped()
        }
    )
    
    private lazy var loginButton = RoundedButton(
        title: "Login",
        titleColor: .white,
        backgroundColor: Colors.primaryColor,
        icon: nil,
        action: { [weak self] in
            self?.delegate?.signInButtonDidTapped()
        }
    )
    
    private lazy var signInOptionsLabel = makeLabel(
        text: "OR",
        font: Fonts.medium(size: 14).weight,
        color: .black,
        textAlignment: .center
    )
    
    private lazy var separatorStackView = makeStackView(
        with: [
            makeSeparatorView(color: Colors.descriptionTextColor),
            signInOptionsLabel,
            makeSeparatorView(color: Colors.descriptionTextColor)],
        aligment: .center,
        distribution: .fillEqually,
        spacing: 16,
        axis: .horizontal
    )
    
    private lazy var loginWithGoogleButton = RoundedButton(
        title: "Login with Google",
        titleColor: .black,
        backgroundColor: Colors.backgroundColor,
        icon: UIImage(named: "google-icon"),
        action: { [weak self] in
            self?.delegate?.loginWithGoogleButtonDidTapped()
        }
    )
    
    private lazy var dontHaveAccountLabel = makeLabel(
        text: "Don't have account?",
        font: Fonts.medium(size: 14).weight,
        color: .black
    )
    
    private lazy var registerButton = makeButton(
        title: "Register",
        titleColor: Colors.primaryColor,
        font: Fonts.semiBold(size: 14).weight,
        action: UIAction { [weak self] _ in
            self?.delegate?.registerButtonDidTapped()
        }
    )
    
    private lazy var registerStack = makeStackView(with: [dontHaveAccountLabel,
                                                          registerButton],
                                                   aligment: .center,
                                                   spacing: 2,
                                                   axis: .horizontal)
    
    private lazy var loadingView = LoadingView()
    
    func goToNextField(_ textField: UITextField, action: (() -> Void)) {
        switch textField.tag {
        case 0:
            passwordTextField.becomeFirstResponder()
        case 1:
            action()
            passwordTextField.resignFirstResponder()
        default: return
        }
    }
    
    func getUserLoginRequest() -> LoginRequest? {
        guard let email = emailTextField.text,
              let password = passwordTextField.text
        else { return nil }
        return LoginRequest(email: email, password: password)
    }
    
    func setupValidationErrors(viewModel: FieldValidationViewModel) {
        emailTextField.setDescriptionField(viewModel: viewModel)
        passwordTextField.setDescriptionField(viewModel: viewModel)
    }
    
    func handleLoadingAnimation(_ isLoading: Bool) {
        isUserInteractionEnabled = !isLoading
        isLoading ? loadingView.startLoading() : loadingView.stopLoading()
    }
}

extension LoginScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(customScrollView)
        addSubview(loadingView)
        customScrollView.addSubview(loginAccountHeadlineLabel)
        customScrollView.addSubview(signInLabel)
        customScrollView.addSubview(emailAdressLabel)
        customScrollView.addSubview(emailTextField)
        customScrollView.addSubview(passwordLabel)
        customScrollView.addSubview(passwordTextField)
        customScrollView.addSubview(forgotPasswordButton)
        customScrollView.addSubview(loginButton)
        customScrollView.addSubview(separatorStackView)
        customScrollView.addSubview(loginWithGoogleButton)
        customScrollView.addSubview(registerStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            customScrollView.topAnchor.constraint(equalTo: topAnchor),
            customScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            loginAccountHeadlineLabel.topAnchor.constraint(equalTo: customScrollView.container.topAnchor, constant: 40),
            loginAccountHeadlineLabel.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            loginAccountHeadlineLabel.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            
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
            loginWithGoogleButton.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            loginWithGoogleButton.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            loginWithGoogleButton.heightAnchor.constraint(equalToConstant: 52),
            
            registerStack.topAnchor.constraint(equalTo: loginWithGoogleButton.bottomAnchor, constant: 16),
            registerStack.centerXAnchor.constraint(equalTo: customScrollView.container.centerXAnchor),
            registerStack.heightAnchor.constraint(equalToConstant: 44),
            registerStack.bottomAnchor.constraint(equalTo: customScrollView.container.bottomAnchor),
            
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    
    func setupAddiotionalConfiguration() {
        emailTextField.becomeFirstResponder()
        forgotPasswordButton.contentHorizontalAlignment = .right
    }
}
