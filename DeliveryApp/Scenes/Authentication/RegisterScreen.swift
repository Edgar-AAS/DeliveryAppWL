import UIKit

final class RegisterScreen: UIView {
    weak var delegate: RegisterScreenDelegate?
    weak var textFieldDelegate: UITextFieldDelegate?
    weak var checkBoxDelegate: CheckBoxDelegate?
    
    private var textFields: [DAFormTextField] {
        return [emailTextField, userNameTextField, passwordTextField, passwordConfirmTextField]
    }

    init(delegate: RegisterScreenDelegate,
         textFieldDelegate: UITextFieldDelegate,
         checkBoxDelegate: CheckBoxDelegate) {
        
        self.delegate = delegate
        self.textFieldDelegate = textFieldDelegate
        self.checkBoxDelegate = checkBoxDelegate
        super.init(frame: .zero)
        
        setupView()
        hideKeyboardOnTap()
        setupKeyboardHandling(scrollView: customScrollView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var customScrollView = DAScrollView()
    private lazy var loadingView = DALoadingView()
    
    private lazy var createNewAccountHeadlineLabel = makeLabel(
        text: "Create your new account",
        font: Fonts.semiBold(size: 32).weight,
        color: .black,
        textAlignment: .left,
        numberOfLines: 0
    )
    
    private lazy var createAccountDescriptionLabel = makeLabel(
        text: "Create an account to start looking for the food you like.",
        font: Fonts.medium(size: 16).weight,
        color: Colors.descriptionText,
        textAlignment: .left,
        numberOfLines: 0
    )
    
    private lazy var emailAdressLabel = makeLabel(
        text: "Email Address",
        font: Fonts.medium(size: 14).weight,
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
    
    private lazy var userNameLabel = makeLabel(
        text: "User Name",
        font: Fonts.medium(size: 14).weight,
        color: .black,
        textAlignment: .left
    )
    
    private lazy var userNameTextField = DAFormTextField(
        placeholder: "Enter Name",
        fieldType: "regular",
        tag: 1,
        returnKeyType: .next,
        delegate: textFieldDelegate
    )
    
    private lazy var passwordLabel = makeLabel(
        text: "Password",
        font: Fonts.medium(size: 14).weight,
        color: .black,
        textAlignment: .left
    )
    
    private lazy var passwordTextField = DAFormTextField(
        placeholder: "Enter Password",
        fieldType: "password",
        tag: 2,
        returnKeyType: .next,
        delegate: textFieldDelegate
    )
    
    private lazy var passwordConfirmLabel = makeLabel(
        text: "Password Confirm",
        font: Fonts.medium(size: 14).weight,
        color: .black,
        textAlignment: .left
    )
    
    private lazy var passwordConfirmTextField = DAFormTextField(
        placeholder: "Password Confirm",
        fieldType: "passwordConfirm",
        tag: 3,
        returnKeyType: .done,
        delegate: textFieldDelegate
    )
    
    private lazy var checkBox = DACheckBoxButton(delegate: checkBoxDelegate)
    
    private lazy var termsOfServiceButton = DATitleButton(
        title: "Terms of Service",
        titleColor: .primary1,
        font:  Fonts.medium(size: 14).weight,
        action: {
            print("show Terms of Service")
        }
    )
    
    private lazy var termsAndPrivacyPolicyTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.delegate = self
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainer.lineFragmentPadding = 0.0
        textView.textContainerInset = .zero
        
        let text = "I Agree with Terms of Service and Privacy Policy"
        
        let serviceTermsLinkText = "Terms of Service"
        let privacyPolicyLinkText = "Privacy Policy"
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: Fonts.regular(size: 14).weight,
            .foregroundColor: UIColor.black
        ]
        
        let serviceTermsLinkTextAttributes: [NSAttributedString.Key: Any] = [
            .font: Fonts.bold(size: 14).weight,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .link: URL(string: "https://www.google.com")!
        ]
        
        let privacyPolicyLinkTextAttributes: [NSAttributedString.Key: Any] = [
            .font: Fonts.bold(size: 14).weight,
            .underlineStyle: NSUnderlineStyle.single.rawValue,
            .link: URL(string: "https://www.apple.com")!
        ]
        
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        
        let termsRange = (text as NSString).range(of: serviceTermsLinkText)
        let privacyPolicyRange = (text as NSString).range(of: privacyPolicyLinkText)
        
        attributedString.addAttributes(serviceTermsLinkTextAttributes, range: termsRange)
        attributedString.addAttributes(privacyPolicyLinkTextAttributes, range: privacyPolicyRange)
        
        textView.attributedText = attributedString
        textView.backgroundColor = .clear
        return textView
    }()
    
    
    private lazy var registerButton = DARoundedButton(
        title: "Register",
        titleColor: .white,
        color: .primary1,
        icon: nil,
        action: { [weak self] in
            guard let self else { return }
            self.delegate?.registerButtonDidTapped(self)
        }
    )
    
    private lazy var alternativeLoginLabel = makeLabel(
        text: "OR",
        font: Fonts.medium(size: 14).weight,
        color: .black,
        textAlignment: .center
    )
    
    private lazy var alreadyHaveAccountLabel = makeLabel(
        text: "Already have an account?",
        font: Fonts.medium(size: 14).weight,
        color: .black,
        textAlignment: .center
    )
    
    private lazy var goToLoginButton = DATitleButton(
        title: "Login here",
        titleColor: .primary1,
        font: Fonts.semiBold(size: 14).weight,
        action: { [weak self] in
            guard let self else { return }
            self.delegate?.goToLoginButtonDidTapped(self)
        }
    )
    
    private lazy var loginStack: UIStackView = {
        return makeStackView(
            with: [alreadyHaveAccountLabel,
                   goToLoginButton],
            aligment: .center,
            spacing: 2,
            axis: .horizontal)
    }()
    
    func goToNextField(_ textField: UITextField, action: (() -> Void)) {
        switch textField.tag {
        case 0:
            userNameTextField.becomeFirstResponder()
        case 1:
            passwordTextField.becomeFirstResponder()
        case 2:
            passwordConfirmTextField.becomeFirstResponder()
        case 3:
            action()
            passwordConfirmTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    func getRequest() -> RegisterAccountModel? {
        if let email = emailTextField.text,
           let username = userNameTextField.text,
           let password = passwordTextField.text,
           let confirmPassword = passwordConfirmTextField.text {
            
            return RegisterAccountModel(
                email: email,
                username: username,
                password: password,
                confirmPassword: confirmPassword)
        } else {
            return nil
        }
    }
    
    func handleLoadingView(with state: Bool) {
        loadingView.handleLoading(with: state)
    }
}

extension RegisterScreen: UITextViewDelegate {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        return false
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        return false
    }
}

extension RegisterScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(customScrollView)
        addSubview(loadingView)
        customScrollView.addSubview(createNewAccountHeadlineLabel)
        customScrollView.addSubview(createAccountDescriptionLabel)
        customScrollView.addSubview(emailAdressLabel)
        customScrollView.addSubview(emailTextField)
        customScrollView.addSubview(userNameLabel)
        customScrollView.addSubview(userNameTextField)
        customScrollView.addSubview(passwordLabel)
        customScrollView.addSubview(passwordTextField)
        customScrollView.addSubview(passwordConfirmLabel)
        customScrollView.addSubview(passwordConfirmTextField)
        customScrollView.addSubview(checkBox)
        customScrollView.addSubview(termsAndPrivacyPolicyTextView)
        customScrollView.addSubview(registerButton)
        customScrollView.addSubview(loginStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            customScrollView.topAnchor.constraint(equalTo: topAnchor),
            customScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            createNewAccountHeadlineLabel.topAnchor.constraint(equalTo: customScrollView.container.topAnchor, constant: 36),
            createNewAccountHeadlineLabel.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            createNewAccountHeadlineLabel.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            
            createAccountDescriptionLabel.topAnchor.constraint(equalTo: createNewAccountHeadlineLabel.bottomAnchor, constant: 8),
            createAccountDescriptionLabel.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            createAccountDescriptionLabel.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            
            emailAdressLabel.topAnchor.constraint(equalTo: createAccountDescriptionLabel.bottomAnchor, constant: 24),
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
            
            termsAndPrivacyPolicyTextView.centerYAnchor.constraint(equalTo: checkBox.centerYAnchor),
            termsAndPrivacyPolicyTextView.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 4),
            termsAndPrivacyPolicyTextView.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            
            registerButton.topAnchor.constraint(equalTo: termsAndPrivacyPolicyTextView.bottomAnchor, constant: 24),
            registerButton.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 52),
            
            loginStack.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 16),
            loginStack.centerXAnchor.constraint(equalTo: customScrollView.container.centerXAnchor),
            loginStack.heightAnchor.constraint(equalToConstant: 44),
            loginStack.bottomAnchor.constraint(equalTo: customScrollView.container.bottomAnchor),
            
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        emailTextField.becomeFirstResponder()
    }
}
