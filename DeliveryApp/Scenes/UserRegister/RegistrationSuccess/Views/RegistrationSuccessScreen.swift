import UIKit

class RegistrationSuccessScreen: UIView {
    private weak var delegate: RegistrationSuccessScreenDelegate?
    
    init(delegate: RegistrationSuccessScreenDelegate) {
        self.delegate = delegate
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var customScrollView: CustomScrollView = {
        let scrollView = CustomScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var illustrationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.primaryColor
        imageView.image = UIImage(named: Assets.RegistrationSuccess.image)
        return imageView
    }()
    
    private lazy var titleLabel = makeLabel(
        text: Strings.RegistrationSuccess.title,
        font: Fonts.semiBold(size: 24).weight,
        color: .black,
        textAlignment: .center,
        numberOfLines: 0
    )
    
    private lazy var descriptionLabel = makeLabel(
        text: Strings.RegistrationSuccess.description,
        font: Fonts.regular(size: 16).weight,
        color: Colors.descriptionTextColor,
        textAlignment: .center,
        numberOfLines: 0
    )
    
    private lazy var handleButton = RoundedButton(
        title: Strings.RegistrationSuccess.buttonTitle,
        titleColor: .white,
        backgroundColor: Colors.primaryColor,
        icon: nil,
        action: { [weak self] in
            self?.delegate?.handleButtonDidTapped()
        }
    )
}

extension RegistrationSuccessScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(customScrollView)
        addSubview(handleButton)
        customScrollView.addSubview(illustrationImageView)
        customScrollView.addSubview(titleLabel)
        customScrollView.addSubview(descriptionLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            customScrollView.topAnchor.constraint(equalTo: topAnchor),
            customScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
        
            illustrationImageView.topAnchor.constraint(equalTo: customScrollView.container.topAnchor, constant: 48),
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
            
            handleButton.topAnchor.constraint(equalTo: customScrollView.bottomAnchor, constant: 32),
            handleButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            handleButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            handleButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -16),
            handleButton.heightAnchor.constraint(equalToConstant: 52)
        ])
    }
    
    func setupAddiotionalConfiguration() {
        backgroundColor = Colors.backgroundColor
    }
}
