import UIKit

protocol ForgotPasswordScreenDelegate: AnyObject {
    func continueButtonDidTapped()
}

class ForgotPasswordScreen: UIView {
    private weak var delegate: ForgotPasswordScreenDelegate?
    private var continueButtonBottomConstraint: NSLayoutConstraint?
    
    init(delegate: ForgotPasswordScreenDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupView()
        setupKeyboardRegister()
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
    
    private lazy var forgotPasswordHeadlineLabel = makeLabel(
        text: "Forgot password?",
        font: Fonts.semiBold(size: 32).weight,
        color: .black,
        textAlignment: .left,
        numberOfLines: 0
    )
    
    private lazy var forgotPasswordDescriptionLabel = makeLabel(
        text: "Enter your email address and we’ll send you confirmation code to reset your password",
        font: Fonts.medium(size: 14).weight,
        color: Colors.descriptionTextColor,
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
        returnKeyType: .continue
    )
    
    private lazy var continueButton = RoundedButton(
        title: "Continue",
        titleColor: .white,
        backgroundColor: Colors.primaryColor,
        icon: nil,
        action: { [weak self] in
            self?.delegate?.continueButtonDidTapped()
        }
    )
    
    func setupValidationErrors(viewModel: FieldValidationViewModel) {
        emailTextField.setDescriptionField(viewModel: viewModel)
    }
    
    func handleLoadingAnimation(_ isLoading: Bool) {
        isUserInteractionEnabled = !isLoading
        continueButton.isEnabled = !isLoading
        
        let newBackgroundColor = isLoading ? Colors.primaryColor.withAlphaComponent(0.6) : Colors.primaryColor
        continueButton.backgroundColor = newBackgroundColor
        isLoading ? loadingView.startLoading() : loadingView.stopLoading()
    }

    func getForgotPasswordUserRequest() -> ForgotPasswordUserRequest? {
        guard let email = emailTextField.text else { return nil }
        return ForgotPasswordUserRequest(email: email)
    }
}

extension ForgotPasswordScreen {
    private func setupKeyboardRegister() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(animateButtonPositionChange),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(animateButtonToOriginalPosition),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func animateButtonPositionChange(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

        continueButtonBottomConstraint?.constant = -keyboardFrame.height + safeAreaInsets.bottom - 16

        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }

    @objc private func animateButtonToOriginalPosition(notification: NSNotification) {
        continueButtonBottomConstraint?.constant = -16

        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
}

extension ForgotPasswordScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(customScrollView)
        addSubview(loadingView)
        addSubview(continueButton)
        customScrollView.addSubview(forgotPasswordHeadlineLabel)
        customScrollView.addSubview(forgotPasswordDescriptionLabel)
        customScrollView.addSubview(emailAdressLabel)
        customScrollView.addSubview(emailTextField)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            customScrollView.topAnchor.constraint(equalTo: topAnchor),
            customScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            forgotPasswordHeadlineLabel.topAnchor.constraint(equalTo: customScrollView.container.topAnchor, constant: 24),
            forgotPasswordHeadlineLabel.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            forgotPasswordHeadlineLabel.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            
            forgotPasswordDescriptionLabel.topAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.bottomAnchor, constant: 8),
            forgotPasswordDescriptionLabel.leadingAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.leadingAnchor),
            forgotPasswordDescriptionLabel.trailingAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.trailingAnchor),
            
            emailAdressLabel.topAnchor.constraint(equalTo: forgotPasswordDescriptionLabel.bottomAnchor, constant: 32),
            emailAdressLabel.leadingAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.leadingAnchor),
            emailAdressLabel.trailingAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailAdressLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 52),
            
            continueButton.topAnchor.constraint(greaterThanOrEqualTo: emailTextField.bottomAnchor, constant: 32),
            continueButton.leadingAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: forgotPasswordHeadlineLabel.trailingAnchor),
            continueButton.heightAnchor.constraint(equalToConstant: 52),
            
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        continueButtonBottomConstraint = continueButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16)
        continueButtonBottomConstraint?.isActive = true
    }
    
    func setupAdditionalConfiguration() {
        emailTextField.becomeFirstResponder()
    }
}
