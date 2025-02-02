import UIKit

final class NetworkErrorScreen: UIView {
    override init(frame: CGRect) {
        super .init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var customScrollView = DAScrollView()
    
    private lazy var errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "loadingError-logo")
        return imageView
    }()
    
    private lazy var titleErrorLabel = makeLabel(
        text: "Erro de Conexão",
        font: Fonts.bold(size: 18).weight,
        color: .black,
        textAlignment: .center
    )
    
    private lazy var descriptionErrorLabel = makeLabel(
        text: "Não foi possível conectar ao servidor. Verifique sua conexão com a internet e tente novamente.",
        font: Fonts.regular(size: 14).weight,
        color: Colors.descriptionText,
        textAlignment: .center,
        numberOfLines: 0
    )
    
    private lazy var tryAgainButton: DARoundedButton = {
        let button = DARoundedButton(
            title: "Try Again",
            font: Fonts.bold(size: 16).weight,
            titleColor: Colors.primary,
            color: Colors.background,
            action:  {
                print("dasidais")
            })
        button.layer.cornerRadius = 22
        button.clipsToBounds = true
        button.layer.borderColor = Colors.primary.cgColor
        button.layer.borderWidth = 2
        return button
    }()
}

extension NetworkErrorScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(customScrollView)
        customScrollView.addSubview(errorImageView)
        customScrollView.addSubview(titleErrorLabel)
        customScrollView.addSubview(descriptionErrorLabel)
        customScrollView.addSubview(tryAgainButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            customScrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            customScrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            customScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            customScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            errorImageView.topAnchor.constraint(greaterThanOrEqualTo: customScrollView.container.topAnchor, constant: 16),
            errorImageView.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 16),
            errorImageView.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -16),
            errorImageView.centerYAnchor.constraint(equalTo: customScrollView.container.centerYAnchor, constant: -50),
            errorImageView.heightAnchor.constraint(equalTo: errorImageView.widthAnchor, multiplier: 448/532),
            
            titleErrorLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 16),
            titleErrorLabel.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 16),
            titleErrorLabel.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -16),
            
            descriptionErrorLabel.topAnchor.constraint(equalTo: titleErrorLabel.bottomAnchor, constant: 8),
            descriptionErrorLabel.leadingAnchor.constraint(equalTo: customScrollView.container.leadingAnchor, constant: 16),
            descriptionErrorLabel.trailingAnchor.constraint(equalTo: customScrollView.container.trailingAnchor, constant: -16),
            
            tryAgainButton.topAnchor.constraint(equalTo: descriptionErrorLabel.bottomAnchor, constant: 32),
            tryAgainButton.centerXAnchor.constraint(equalTo: customScrollView.container.centerXAnchor),
            tryAgainButton.widthAnchor.constraint(equalTo: customScrollView.container.widthAnchor, multiplier: 0.4),
            tryAgainButton.heightAnchor.constraint(equalToConstant: 44),
            tryAgainButton.bottomAnchor.constraint(equalTo: customScrollView.container.bottomAnchor)
        ])
    }
}
