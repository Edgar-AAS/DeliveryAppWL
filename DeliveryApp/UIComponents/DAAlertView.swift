import UIKit

final class DAAlertView: UIView {
    private let image: UIImage?
    private let title: String
    private let descriptionText: String
    private let buttonTitle: String
    private var onClose: (() -> Void)?

    init(image: UIImage?,
         title: String,
         descriptionText: String = "",
         buttonTitle: String = "OK",
         onClose: (() -> Void)? = nil)
    {
        self.image = image
        self.title = title
        self.descriptionText = descriptionText
        self.buttonTitle = buttonTitle
        self.onClose = onClose
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        view.backgroundColor = .white
        return view
    }()

    private lazy var alertImageView: UIImageView = {
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Colors.primary
        return imageView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.font = Fonts.bold(size: 16).weight
        label.textAlignment = .center
        label.textColor = .black
        label.accessibilityLabel = title
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = descriptionText
        label.font = Fonts.regular(size: 14).weight
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(buttonTitle, for: .normal)
        button.titleLabel?.font =  Fonts.medium(size: 15).weight
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.primary
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()

    @objc private func closeButtonTapped() {
        onClose?()
        hideAlert()
    }

    func showAlert(in view: UIView) {
        view.endEditing(true)
        
        view.addSubview(self)
                
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.topAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
                
        alpha = 0
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }

    private func hideAlert() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alpha = 0
        }) { _ in
            self.removeFromSuperview()
        }
    }
}

extension DAAlertView: CodeView {
    func buildViewHierarchy() {
        addSubview(containerView)
        containerView.addSubview(alertImageView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(closeButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 270),
            
            alertImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            alertImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            alertImageView.widthAnchor.constraint(equalToConstant: 90),
            alertImageView.heightAnchor.constraint(equalToConstant: 90),
            
            titleLabel.topAnchor.constraint(equalTo: alertImageView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            closeButton.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 8),
            closeButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: 100),
            closeButton.heightAnchor.constraint(equalToConstant: 40),
            closeButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }
}
