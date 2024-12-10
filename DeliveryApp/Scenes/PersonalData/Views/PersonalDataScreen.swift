import UIKit

protocol PersonalDataScreenDelegate: AnyObject {
    func personalImageDidTapped(_ view: PersonalDataScreen)
}

final class PersonalDataScreen: UIView {
    private weak var textFieldDelegate: UITextFieldDelegate?
    private weak var delegate: PersonalDataScreenDelegate?
    
    var profileImage: UIImage? {
        didSet {
            personalImageView.image = profileImage
        }
    }
    
    init(textFieldDelegate: UITextFieldDelegate? = nil, delegate: PersonalDataScreenDelegate) {
        self.textFieldDelegate = textFieldDelegate
        self.delegate = delegate
        super.init(frame: .zero)
        
        setupView()
        hideKeyboardOnTap()
        setupKeyboardHandling(scrollView: customScrollView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var customScrollView = CustomScrollView()
    private lazy var loadingView = LoadingView()
    
    private lazy var personalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.layer.cornerRadius = 50
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        let gestureRecoginizer = UITapGestureRecognizer(target: self,action: #selector(handleImageTap))
        imageView.addGestureRecognizer(gestureRecoginizer)
        return imageView
    }()
    
    @objc private func handleImageTap() {
        delegate?.personalImageDidTapped(self)
    }
    
    private lazy var userNameLabel = makeLabel(
        text: "User Name",
        font: Fonts.medium(size: 14).weight,
        color: .black,
        textAlignment: .left
    )
    
    private lazy var userNameTextField = FormTextField(
        placeholder: "Enter Name",
        fieldType: "regular",
        tag: 0,
        returnKeyType: .next,
        delegate: textFieldDelegate
    )
    
    private lazy var dateOfBirthLabel = makeLabel(
        text: "Date of Birth",
        font: Fonts.medium(size: 14).weight,
        color: .black,
        textAlignment: .left
    )
    
    private lazy var dateOfBirthTextField = FormTextField(
        placeholder: "Enter Date",
        fieldType: "date",
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
    
    private lazy var phoneTextField = FormTextField(
        placeholder: "Enter Phone",
        fieldType: "phone",
        tag: 3,
        returnKeyType: .next,
        delegate: textFieldDelegate
    )
    
    private lazy var emailAdressLabel = makeLabel(
        text: "Email Address",
        font: Fonts.medium(size: 14).weight,
        color: .black,
        textAlignment: .left
    )
    
    private lazy var emailTextField = FormTextField(
        placeholder: "Enter Email",
        fieldType: "email",
        tag: 4,
        returnKeyType: .done,
        delegate: textFieldDelegate
    )
        
    private lazy var saveButton = RoundedButton(
        title: "Save",
        titleColor: .white,
        backgroundColor: Colors.primary,
        icon: nil,
        action: { [weak self] in
            print(#function)
        }
    )
    
    func handleLoadingView(with state: LoadingStateModel) {
        loadingView.handleLoading(with: state)
    }
    
    func goToNextField(_ textField: UITextField, action: (() -> Void)? = nil) {
        switch textField.tag {
        case 0:
            dateOfBirthTextField.becomeFirstResponder()
        case 1:
            phoneTextField.becomeFirstResponder()
        case 2:
            emailTextField.becomeFirstResponder()
        case 3:
            action?()
            emailTextField.resignFirstResponder()
        default:
            return
        }
    }
}

extension PersonalDataScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(customScrollView)
        addSubview(loadingView)
        customScrollView.addSubview(personalImageView)
        customScrollView.addSubview(userNameLabel)
        customScrollView.addSubview(userNameTextField)
        customScrollView.addSubview(dateOfBirthLabel)
        customScrollView.addSubview(dateOfBirthTextField)
        customScrollView.addSubview(phoneLabel)
        customScrollView.addSubview(phoneTextField)
        customScrollView.addSubview(emailAdressLabel)
        customScrollView.addSubview(emailTextField)
        customScrollView.addSubview(saveButton)
    }
    
    func setupConstraints() {
        let leftRightPadding: CGFloat = 24
        let paddingBetweenFields: CGFloat = 24
        
        NSLayoutConstraint.activate([
            customScrollView.topAnchor.constraint(equalTo: topAnchor),
            customScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            personalImageView.topAnchor.constraint(equalTo: customScrollView.container.safeAreaLayoutGuide.topAnchor, constant: 36),
            personalImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            userNameLabel.topAnchor.constraint(equalTo: personalImageView.bottomAnchor, constant: paddingBetweenFields),
            userNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftRightPadding),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -leftRightPadding),
            
            userNameTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            userNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftRightPadding),
            userNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -leftRightPadding),
            userNameTextField.heightAnchor.constraint(equalToConstant: 52),
            
            dateOfBirthLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: paddingBetweenFields),
            dateOfBirthLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftRightPadding),
            dateOfBirthLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: leftRightPadding),
            
            dateOfBirthTextField.topAnchor.constraint(equalTo: dateOfBirthLabel.bottomAnchor, constant: 8),
            dateOfBirthTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftRightPadding),
            dateOfBirthTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -leftRightPadding),
            dateOfBirthTextField.heightAnchor.constraint(equalToConstant: 52),
            
            phoneLabel.topAnchor.constraint(equalTo: dateOfBirthTextField.bottomAnchor, constant: paddingBetweenFields),
            phoneLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftRightPadding),
            phoneLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -leftRightPadding),
            
            phoneTextField.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 8),
            phoneTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftRightPadding),
            phoneTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -leftRightPadding),
            phoneTextField.heightAnchor.constraint(equalToConstant: 52),
            
            emailAdressLabel.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: paddingBetweenFields),
            emailAdressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftRightPadding),
            emailAdressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -leftRightPadding),
            
            emailTextField.topAnchor.constraint(equalTo: emailAdressLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftRightPadding),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -leftRightPadding),
            emailTextField.heightAnchor.constraint(equalToConstant: 52),
            
            saveButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 32),
            saveButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftRightPadding),
            saveButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -leftRightPadding),
            saveButton.bottomAnchor.constraint(equalTo: customScrollView.container.bottomAnchor),
            saveButton.heightAnchor.constraint(equalToConstant: 52),
            
            loadingView.topAnchor.constraint(equalTo: topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        userNameTextField.becomeFirstResponder()
    }
}
