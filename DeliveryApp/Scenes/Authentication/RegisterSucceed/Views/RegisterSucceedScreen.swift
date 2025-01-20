import UIKit

final class RegisterSucceedScreen: UIView {
    private weak var delegate: RegisterSucceedScreenDelegate?
    
    init(delegate: RegisterSucceedScreenDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var customScrollView: DAScrollView = {
        let scrollView = DAScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.primary
        imageView.image = UIImage(named: Assets.Images.successRegister)
        return imageView
    }()
    
    private lazy var titleLabel = makeLabel(
        text: Strings.RegistrationAccount.Success.title,
        font: Fonts.semiBold(size: 24).weight,
        color: .black,
        textAlignment: .center,
        numberOfLines: 0
    )
    
    private lazy var descriptionLabel = makeLabel(
        text: Strings.RegistrationAccount.Success.description,
        font: Fonts.regular(size: 16).weight,
        color: Colors.descriptionText,
        textAlignment: .center,
        numberOfLines: 0
    )
    
    private lazy var verifyAccountButton = DARoundedButton(
        title: Strings.RegistrationAccount.Success.verifyAccountTitle,
        titleColor: .white,
        backgroundColor: Colors.primary,
        icon: nil,
        action: { [weak self] in
            guard let self else { return }
            delegate?.verifyAccountButtonDidTapped(self)
        }
    )
}

extension RegisterSucceedScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(customScrollView)
        addSubview(verifyAccountButton)
        customScrollView.addSubview(illustrationImageView)
        customScrollView.addSubview(titleLabel)
        customScrollView.addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            customScrollView.topAnchor.constraint(equalTo: topAnchor),
            customScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
        
            illustrationImageView.centerYAnchor.constraint(equalTo: customScrollView.container.centerYAnchor),
            illustrationImageView.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor),
            illustrationImageView.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor),
            illustrationImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: illustrationImageView.bottomAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -24),
            descriptionLabel.bottomAnchor.constraint(equalTo: customScrollView.container.bottomAnchor),
            
            verifyAccountButton.topAnchor.constraint(equalTo: customScrollView.bottomAnchor, constant: 32),
            verifyAccountButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            verifyAccountButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            verifyAccountButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            verifyAccountButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = Colors.background
    }
}
