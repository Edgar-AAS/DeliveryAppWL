import UIKit

final class ProductDetailsHeader: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = Fonts.semiBold(size: 24).weight
        return label
    }()
    
    private lazy var backButton: CircularButton = {
        let button = CircularButton(iconImage: .init(systemName: "arrow.left"), size: 36)
        button.layer.borderColor = UIColor.white.cgColor
        button.tintColor = .white
        button.layer.borderWidth = 1
        
        let action = UIAction { [weak self] _ in
            //            self?.delegate?.backButtonDidTapped()
        }
        
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: CircularButton = {
        let button = CircularButton(iconImage: .init(systemName: "heart"), size: 36)
        button.layer.borderColor = UIColor.white.cgColor
        button.tintColor = .white
        
        let action = UIAction { [weak self] _ in
            //            self?.delegate?.favoriteButtonDidTapped()
        }
        button.addAction(action, for: .touchUpInside)
        button.layer.borderWidth = 1
        return button
    }()
    
    private lazy var topButtonsStack = makeStackView(with: [backButton, favoriteButton],
                                                     aligment: .fill,
                                                     distribution: .equalSpacing,
                                                     spacing: 8,
                                                     axis: .horizontal)
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = Fonts.regular(size: 16).weight
        label.textColor = .darkGray
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return label
    }()
    
    private lazy var basePriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private lazy var productBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var deliveryFeeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "delivery-fee-icon")
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var estimatedTimeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "clock")
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var ratingIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var deliveryFeeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.semiBold(size: 14).weight
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var deliveryTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.semiBold(size: 14).weight
        label.text = "14-30 Min"
        label.textColor = .darkGray
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.semiBold(size: 14).weight
        label.textColor = .darkGray
        return label
    }()
        
    private lazy var deliveryFeeStack: UIStackView = {
        return makeStackView(with: [deliveryFeeIcon, deliveryFeeLabel],
                             aligment: .center,
                             distribution: .fill,
                             spacing: 8,
                             axis: .horizontal)
    }()

    private lazy var estimatedTimeStack: UIStackView = {
        return makeStackView(with: [estimatedTimeIcon, deliveryTimeLabel],
                             aligment: .center,
                             distribution: .fill,
                             spacing: 8,
                             axis: .horizontal)
    }()

    private lazy var ratingStack: UIStackView = {
        return makeStackView(with: [ratingIcon, ratingLabel],
                             aligment: .center,
                             distribution: .fill,
                             spacing: 8,
                             axis: .horizontal)
    }()

    private lazy var productOrderInformationsStack = makeStackView(
        with: [deliveryFeeStack, estimatedTimeStack, ratingStack],
        aligment: .center,
        distribution: .equalSpacing,
        axis: .horizontal
    )
    
    private func setupBasePriceTextLabel(prefix: String, price: String) {
        let attributedText = NSMutableAttributedString(
            string: prefix,
            attributes: [
                .font: Fonts.regular(size: 16).weight,
                .foregroundColor: UIColor.darkGray
            ]
        )
        
        let priceAttributedText = NSAttributedString(
            string: price,
            attributes: [
                .font: Fonts.semiBold(size: 16).weight,
                .foregroundColor: UIColor.darkGray
            ]
        )
        
        attributedText.append(priceAttributedText)
        basePriceLabel.attributedText = attributedText
    }
    
    func configure(with viewData: HeaderViewData) {
        productNameLabel.text = viewData.getName()
        descriptionLabel.text = viewData.getDescription()
        setupBasePriceTextLabel(prefix: viewData.getPrefixBasePrice(), price: viewData.getBasePrice())
        deliveryFeeLabel.text = viewData.getDeliveryFee()
        ratingLabel.text = viewData.getRating()
        
        guard
            let imageUrlString = viewData.getImages().first?.url,
            let imageUrl = URL(string: imageUrlString)
        else {
            productImageView.image = UIImage(systemName: "photo")
            return
        }
        productImageView.sd_setImage(with: imageUrl)
    }
}

extension ProductDetailsHeader: CodeView {
    func buildViewHierarchy() {
        addSubview(productImageView)
        addSubview(topButtonsStack)
        addSubview(productNameLabel)
        addSubview(descriptionLabel)
        addSubview(basePriceLabel)
        addSubview(productBackgroundView)
        productBackgroundView.addSubview(productOrderInformationsStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: topAnchor),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: 280),
            
            topButtonsStack.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 16),
            topButtonsStack.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor, constant: 16),
            topButtonsStack.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: -16),
            
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 24),
            productNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            descriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            basePriceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            basePriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            basePriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            productBackgroundView.topAnchor.constraint(equalTo: basePriceLabel.bottomAnchor, constant: 16),
            productBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            productBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            productBackgroundView.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            
            productOrderInformationsStack.topAnchor.constraint(equalTo: productBackgroundView.topAnchor, constant: 8),
            productOrderInformationsStack.leadingAnchor.constraint(equalTo: productBackgroundView.leadingAnchor, constant: 16),
            productOrderInformationsStack.trailingAnchor.constraint(equalTo: productBackgroundView.trailingAnchor, constant: -16),
            productOrderInformationsStack.bottomAnchor.constraint(equalTo: productBackgroundView.bottomAnchor, constant: -8)
        ])
    }
}
