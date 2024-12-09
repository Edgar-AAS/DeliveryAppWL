import UIKit

final class PersonalDataScreen: UIView {
    weak var textFieldDelegate: UITextFieldDelegate?
    
    init(textFieldDelegate: UITextFieldDelegate? = nil)
    {
        self.textFieldDelegate = textFieldDelegate
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
    
    private lazy var personalImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.layer.cornerRadius = 50
        imageView.backgroundColor = .lightGray
        imageView.isUserInteractionEnabled = true
        imageView.clipsToBounds = true
        let gestureRecoginizer = UITapGestureRecognizer(target: self,action: #selector(handleImageTap))
        imageView.addGestureRecognizer(gestureRecoginizer)
        return imageView
    }()
    
    @objc private func handleImageTap() {
        print("handleImageTap")
    }
    
    private lazy var userNameLabel = makeLabel(
        text: "User Name",
        font: Fonts.medium(size: 14).weight,
        color: .black,
        textAlignment: .left
    )
    
    private lazy var userNameTextField = CustomTextField(
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
    
    private lazy var dateOfBirthTextField = CustomTextField(
        placeholder: "Enter Date",
        fieldType: "date",
        tag: 1,
        returnKeyType: .next,
        delegate: textFieldDelegate
    )
    
    private lazy var genderLabel = makeLabel(
        text: "Gender",
        font: Fonts.medium(size: 14).weight,
        color: .black,
        textAlignment: .left
    )
    
    private lazy var genderTextField = CustomTextField(
        placeholder: "Enter Gender",
        fieldType: "gender",
        tag: 2,
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
    
    private lazy var emailTextField = CustomTextField(
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
    
    func goToNextField(_ textField: UITextField, action: (() -> Void)) {
        switch textField.tag {
        case 0:
            dateOfBirthTextField.becomeFirstResponder()
        case 1:
            genderTextField.becomeFirstResponder()
        case 2:
            phoneTextField.becomeFirstResponder()
        case 3:
            emailTextField.becomeFirstResponder()
        case 4:
            action()
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
        customScrollView.addSubview(personalImage)
        customScrollView.addSubview(userNameLabel)
        customScrollView.addSubview(userNameTextField)
        customScrollView.addSubview(dateOfBirthLabel)
        customScrollView.addSubview(dateOfBirthTextField)
        customScrollView.addSubview(genderLabel)
        customScrollView.addSubview(genderTextField)
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
            
            personalImage.topAnchor.constraint(equalTo: customScrollView.container.safeAreaLayoutGuide.topAnchor, constant: 36),
            personalImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            userNameLabel.topAnchor.constraint(equalTo: personalImage.bottomAnchor, constant: paddingBetweenFields),
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
            
            genderLabel.topAnchor.constraint(equalTo: dateOfBirthTextField.bottomAnchor, constant: paddingBetweenFields),
            genderLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftRightPadding),
            genderLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -leftRightPadding),
            
            genderTextField.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 8),
            genderTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leftRightPadding),
            genderTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -leftRightPadding),
            genderTextField.heightAnchor.constraint(equalToConstant: 52),
            
            phoneLabel.topAnchor.constraint(equalTo: genderTextField.bottomAnchor, constant: paddingBetweenFields),
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
            
            saveButton.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: paddingBetweenFields),
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
