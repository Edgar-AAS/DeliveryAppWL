import UIKit

protocol ProductDetailsHeaderDelegateProtocol: AnyObject {
    func backButtonDidTapped(_ header: ProductDetailsHeader)
}

final class ProductDetailsHeader: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private weak var delegate: ProductDetailsHeaderDelegateProtocol?
    
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
    
    private lazy var backButton: DACircularButton = {
        return DACircularButton(
            iconImage: .init(systemName: SFSymbols.arrowDown),
            size: 44,
            tint: .white,
            backgroundColor: UIColor(hexString: "0B0C0E").withAlphaComponent(0.5),
            onTap: { [weak self] in
                guard let self else { return }
                self.delegate?.backButtonDidTapped(self)
            }
        )
    }()
    
    private lazy var favoriteButton: DACircularButton = {
        return DACircularButton(
            iconImage: .init(systemName: SFSymbols.favorite),
            size: 44,
            tint: .white,
            backgroundColor: UIColor(hexString: "0B0C0E").withAlphaComponent(0.5),
            onTap: {
                print(#function)
            }
        )
    }()
    
    private lazy var topButtonsStack: UIStackView = {
        return makeStackView(with: [backButton, favoriteButton],
                             aligment: .fill,
                             distribution: .equalSpacing,
                             spacing: 8,
                             axis: .horizontal)
    }()
    
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
        label.setContentHuggingPriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .vertical)
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
    
    private lazy var productOrderInformationsStack: UIStackView = {
        return makeStackView(with: [deliveryFeeStack, estimatedTimeStack, ratingStack],
                             aligment: .center,
                             distribution: .equalSpacing,
                             axis: .horizontal)
    }()
    
    
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
    
    func configure(with viewData: ProductHeaderViewData, delegate: ProductDetailsHeaderDelegateProtocol) {
        self.delegate = delegate
        
        productNameLabel.text = viewData.displayName
        descriptionLabel.text = viewData.displayDescription
        setupBasePriceTextLabel(prefix: viewData.prefixBasePrice, price: viewData.formattedBasePrice)
        deliveryFeeLabel.text = viewData.displayDeliveryFee
        ratingLabel.text = viewData.stringRating
        
        guard
            let imageUrlString = viewData.sortedImages().first?.url,
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
            productImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            productImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            productImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            productImageView.heightAnchor.constraint(equalToConstant: 300),
            
            topButtonsStack.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 16),
            topButtonsStack.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor, constant: 16),
            topButtonsStack.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: -16),
            
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 24),
            productNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            productNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            descriptionLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            basePriceLabel.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 16),
            basePriceLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            basePriceLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            productBackgroundView.topAnchor.constraint(equalTo: basePriceLabel.bottomAnchor, constant: 8),
            productBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            productBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            productBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            productBackgroundView.heightAnchor.constraint(equalToConstant: 40),
            
            productOrderInformationsStack.topAnchor.constraint(equalTo: productBackgroundView.topAnchor, constant: 8),
            productOrderInformationsStack.leadingAnchor.constraint(equalTo: productBackgroundView.leadingAnchor, constant: 16),
            productOrderInformationsStack.trailingAnchor.constraint(equalTo: productBackgroundView.trailingAnchor, constant: -16),
            productOrderInformationsStack.bottomAnchor.constraint(equalTo: productBackgroundView.bottomAnchor, constant: -8)
        ])
    }
}
