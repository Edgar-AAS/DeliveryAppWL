import UIKit

final class RegisterScreen: UIView {
    weak var delegate: RegisterScreenDelegate?
    weak var textFieldDelegate: UITextFieldDelegate?
    weak var checkBoxDelegate: CheckBoxDelegate?
    
    init(delegate: RegisterScreenDelegate?,
         textFieldDelegate: UITextFieldDelegate?,
         checkBoxDelegate: CheckBoxDelegate) {
        
        self.delegate = delegate
        self.textFieldDelegate = textFieldDelegate
        self.checkBoxDelegate = checkBoxDelegate
        super.init(frame: .zero)
        setupView()
        hideKeyboardOnTap()
        setupResponsiveBehavior(scrollView: customScrollView, referenceView: emailTextField)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var customScrollView: CustomScrollView = {
        let scrollView = CustomScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var loadingView = LoadingView()
    
    private lazy var createNewAccountHeadlineLabel = makeLabel(
        text: "Create your new account",
        font: Fonts.semiBold(size: 32).weight,
        color: .black,
        textAlignment: .left,
        numberOfLines: 0
    )
    
    private lazy var createAccountLabel = makeLabel(
        text: "Create an account to start looking for the food you like",
        font: Fonts.medium(size: 14).weight,
        color: Colors.descriptionText,
        textAlignment: .left,
        numberOfLines: 0
    )
    
    private lazy var emailAdressLabel = makeLabel(
        text: "Email Address",
        font: Fonts.medium(size: 14).weight,
        color: .black,
        textAlignment: .left,
        numberOfLines: 0
    )
    
    private lazy var emailTextField = CustomTextField(
        placeholder: "Enter Email",
        fieldType: .email,
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
    
    private lazy var userNameTextField = CustomTextField(
        placeholder: "Enter Name",
        fieldType: .regular,
        tag: 1,
        returnKeyType: .next,
        delegate: textFieldDelegate
    )
    
    private lazy var phoneLabel = makeLabel(
        text: "Phone",
        font: Fonts.medium(size: 14).weight,
        color: .black,
        textAlignment: .left
    )
    
    private lazy var phoneTextField = CustomTextField(
        placeholder: "Enter Phone",
        fieldType: .phone,
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
    
    private lazy var passwordTextField = CustomTextField(
        placeholder: "Enter Password",
        fieldType: .password,
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
    
    private lazy var passwordConfirmTextField = CustomTextField(
        placeholder: "Password Confirm",
        fieldType: .passwordConfirm,
        tag: 3,
        returnKeyType: .done,
        delegate: textFieldDelegate
    )
    
    private lazy var checkBox = CheckBoxButton(delegate: checkBoxDelegate)
    
    private lazy var termsOfServiceButton = makeTitleButton(
        title: "Terms of Service",
        titleColor: Colors.primary,
        font:  Fonts.medium(size: 14).weight,
        action: UIAction { [weak self] _ in
            print("show Terms of Service")
        }
    )
    
    private lazy var privacyPolicyButton = makeTitleButton(
        title: "Privacy Policy",
        titleColor: Colors.primary,
        font: Fonts.medium(size: 14).weight,
        action: UIAction { [weak self] _ in
            print("show Privacy Policy")
        }
    )
    
    private lazy var termsStackView: UIStackView = {
        let leftLabel = makeLabel(
            text: "I Agree with",
            font: Fonts.medium(size: 14).weight,
            color: .black
        )
        
        let rightLabel = makeLabel(
            text: "and",
            font: Fonts.medium(size: 14).weight,
            color: .black
        )
        
        let stackView = makeStackView(
            with: [leftLabel,
                   termsOfServiceButton,
                   rightLabel,
                   privacyPolicyButton],
            aligment: .center,
            spacing: 4,
            axis: .horizontal
        )
        
        return stackView
    }()
    
    private lazy var registerButton = RoundedButton(
        title: "Register",
        titleColor: .white,
        backgroundColor: Colors.primary,
        icon: nil,
        action: { [weak self] in
            self?.delegate?.registerButtonDidTapped()
        }
    )
    
    private lazy var alternativeLoginLabel = makeLabel(
        text: "OR",
        font: Fonts.medium(size: 14).weight,
        color: .black,
        textAlignment: .center
    )
    
    private lazy var separatorStackView = makeStackView(
        with: [makeSeparatorView(color: Colors.descriptionText),
               alternativeLoginLabel,
               makeSeparatorView(color: Colors.descriptionText)],
        aligment: .center,
        distribution: .fillEqually,
        spacing: 16,
        axis: .horizontal
    )
    
    private lazy var loginWithGoogleButton = RoundedButton(
        title: "Login with Google",
        titleColor: .black,
        backgroundColor: Colors.background,
        icon: UIImage(named: "google-icon"),
        action: { [weak self] in

        }
    )
    
    private lazy var alreadyHaveAccountLabel = makeLabel(
        text: "Already have an account?",
        font: Fonts.medium(size: 14).weight,
        color: .black,
        textAlignment: .center
    )
    
    private lazy var goToLoginButton = makeTitleButton(
        title: "Login here",
        titleColor: Colors.primary,
        font: Fonts.semiBold(size: 14).weight,
        action: UIAction { [weak self] _ in
            self?.delegate?.goToLoginButtonDidTapped()
        }
    )
    
    private lazy var loginStack = makeStackView(
        with: [alreadyHaveAccountLabel,
               goToLoginButton],
        aligment: .center,
        spacing: 2,
        axis: .horizontal
    )
    
    func goToNextField(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            userNameTextField.becomeFirstResponder()
        case 1:
            passwordTextField.becomeFirstResponder()
        case 2:
            passwordConfirmTextField.becomeFirstResponder()
        case 3:
            passwordConfirmTextField.resignFirstResponder()
        default:
            return
        }
    }
    
    func getRegisterUserRequest() -> RegisterUserRequest? {
        guard let email = emailTextField.text,
              let username = userNameTextField.text,
              let phone = phoneTextField.text,
              let password = passwordTextField.text,
              let confirmPassword = passwordConfirmTextField.text
        else { return nil }
            
        let registerRequest = RegisterUserRequest(
            email: email,
            username: username,
            phone: phone,
            password: password,
            confirmPassword: confirmPassword
        )
        return registerRequest
    }
    
    func setupValidationErrors(viewModel: FieldValidationViewModel) {
        emailTextField.setDescriptionField(viewModel: viewModel)
        userNameTextField.setDescriptionField(viewModel: viewModel)
        phoneTextField.setDescriptionField(viewModel: viewModel)
        passwordTextField.setDescriptionField(viewModel: viewModel)
        passwordConfirmTextField.setDescriptionField(viewModel: viewModel)
    }
    
    func handleLoadingAnimation(_ isLoading: Bool) {
        isUserInteractionEnabled = !isLoading
        isLoading ? loadingView.startLoading() : loadingView.stopLoading()
    }
}

extension RegisterScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(customScrollView)
        addSubview(loadingView)
        customScrollView.addSubview(createNewAccountHeadlineLabel)
        customScrollView.addSubview(createAccountLabel)
        customScrollView.addSubview(emailAdressLabel)
        customScrollView.addSubview(emailTextField)
        customScrollView.addSubview(userNameLabel)
        customScrollView.addSubview(userNameTextField)
        customScrollView.addSubview(phoneLabel)
        customScrollView.addSubview(phoneTextField)
        customScrollView.addSubview(passwordLabel)
        customScrollView.addSubview(passwordTextField)
        customScrollView.addSubview(passwordConfirmLabel)
        customScrollView.addSubview(passwordConfirmTextField)
        customScrollView.addSubview(checkBox)
        customScrollView.addSubview(termsStackView)
        customScrollView.addSubview(registerButton)
        customScrollView.addSubview(separatorStackView)
        customScrollView.addSubview(loginWithGoogleButton)
        customScrollView.addSubview(loginStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            customScrollView.topAnchor.constraint(equalTo: topAnchor),
            customScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            createNewAccountHeadlineLabel.topAnchor.constraint(equalTo: customScrollView.container.topAnchor),
            createNewAccountHeadlineLabel.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            createNewAccountHeadlineLabel.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            
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
            
            phoneLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 24),
            phoneLabel.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            
            phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            phoneTextField.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            phoneTextField.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            phoneTextField.heightAnchor.constraint(equalToConstant: 52),
            
            passwordLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 24),
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
            
            termsStackView.centerYAnchor.constraint(equalTo: checkBox.centerYAnchor),
            termsStackView.leadingAnchor.constraint(equalTo: checkBox.trailingAnchor, constant: 4),
            termsStackView.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            
            registerButton.topAnchor.constraint(equalTo: termsStackView.bottomAnchor, constant: 24),
            registerButton.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 52),
            
            separatorStackView.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 16),
            separatorStackView.leadingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.leadingAnchor),
            separatorStackView.trailingAnchor.constraint(equalTo: createNewAccountHeadlineLabel.trailingAnchor),
            
            loginWithGoogleButton.topAnchor.constraint(equalTo: separatorStackView.bottomAnchor, constant: 16),
            loginWithGoogleButton.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            loginWithGoogleButton.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            loginWithGoogleButton.heightAnchor.constraint(equalToConstant: 52),
            
            loginStack.topAnchor.constraint(equalTo: loginWithGoogleButton.bottomAnchor, constant: 16),
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
