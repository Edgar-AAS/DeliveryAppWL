import UIKit

class ResetPasswordScreen: UIView {
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
        scrollView.backgroundColor = Colors.backgroundColor
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let resetPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Reset Password"
        label.font = Fonts.semiBold(size: 32).weight
        label.textAlignment = .left
        label.textColor = .black
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var resetPasswordDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your new password must be different from the previously used password"
        label.font = Fonts.medium(size: 14).weight
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = Colors.descriptionTextColor
        return label
    }()
    
    private let newPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "New Password"
        label.textColor = .black
        label.font = Fonts.medium(size: 14).weight
        label.textAlignment = .left
        return label
    }()
    
    private lazy var newPasswordField: CustomTextField = {
        let textField = CustomTextField(placeholder: "New Password", fieldType: .password)
        return textField
    }()
    
    private let confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Confirm Password"
        label.textColor = .black
        label.font = Fonts.medium(size: 14).weight
        label.textAlignment = .left
        return label
    }()
    
    let confirmPasswordField = CustomTextField(placeholder: "Confirm Password", fieldType: .password)
    
    private  lazy var verifyAccountButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Verify Account", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = Fonts.bold(size: 14).weight
        button.backgroundColor = Colors.primaryColor
        button.layer.cornerRadius = 26
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 4
        return button
    }()
}

extension ResetPasswordScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(resetPasswordLabel)
        containerView.addSubview(resetPasswordDescriptionLabel)
        containerView.addSubview(newPasswordLabel)
        containerView.addSubview(newPasswordField)
        containerView.addSubview(confirmPasswordLabel)
        containerView.addSubview(confirmPasswordField)
        containerView.addSubview(verifyAccountButton)
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
            
            resetPasswordLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 40),
            resetPasswordLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            resetPasswordLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            resetPasswordDescriptionLabel.topAnchor.constraint(equalTo: resetPasswordLabel.bottomAnchor, constant: 8),
            resetPasswordDescriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            resetPasswordDescriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            newPasswordLabel.topAnchor.constraint(equalTo: resetPasswordDescriptionLabel.bottomAnchor, constant: 24),
            newPasswordLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            newPasswordLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            newPasswordField.topAnchor.constraint(equalTo: newPasswordLabel.bottomAnchor, constant: 8),
            newPasswordField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            newPasswordField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            newPasswordField.heightAnchor.constraint(equalToConstant: 52),
            
            confirmPasswordLabel.topAnchor.constraint(equalTo: newPasswordField.bottomAnchor, constant: 24),
            confirmPasswordLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            confirmPasswordLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            confirmPasswordField.topAnchor.constraint(equalTo: confirmPasswordLabel.bottomAnchor, constant: 8),
            confirmPasswordField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            confirmPasswordField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            confirmPasswordField.heightAnchor.constraint(equalToConstant: 52),
            
            verifyAccountButton.topAnchor.constraint(equalTo: confirmPasswordField.bottomAnchor, constant: 60),
            verifyAccountButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            verifyAccountButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            verifyAccountButton.heightAnchor.constraint(equalToConstant: 52),
            verifyAccountButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
    }
}
