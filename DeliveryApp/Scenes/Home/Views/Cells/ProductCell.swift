import UIKit
import SDWebImage

class ProductCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: ProductCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var productImageView: UIImageView = {
        let imageView = makeImageView()
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
        
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .red
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.widthAnchor.constraint(equalToConstant: 35).isActive = true
        button.layer.cornerRadius = 17.5
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = .init(width: 1, height: 1)
        button.layer.shadowOpacity = 0.2
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var productNameLabel: UILabel = {
        return makeLabel(
            font: Fonts.medium(size: 16).weight,
            color: .black,
            numberOfLines: 0
        )
    }()
    
    private lazy var valueTitleLabel: UILabel = {
        let label = makeLabel(
            text: "A partir de",
            font: Fonts.regular(size: 14).weight,
            color: .black,
            numberOfLines: 0
        )
        return label
    }()
    
    private lazy var productRateIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = Colors.primary
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var productRateLabel = makeLabel(font: Fonts.medium(size: 12).weight, color: .black)
    
    private lazy var distanceLabel = makeLabel(font: Fonts.medium(size: 12).weight, color: .black)
    
    private lazy var productInfoStack = makeStackView(with: [productPriceLabel,
                                                             productRateIcon,
                                                             productRateLabel],
                                                      spacing: 4,
                                                      axis: .horizontal)
    
    private lazy var productPriceLabel = makeLabel(
        font: Fonts.bold(size: 16).weight,
        color: .black
    )
    
    func configure(with viewData: ProductCellViewData) {
        productNameLabel.text = viewData.displayName
        productPriceLabel.text = viewData.formattedPrice
        productRateLabel.text = viewData.stringRating
        favoriteButton.imageView?.image = viewData.favoriteStatus ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        
        let imageUrl = viewData.sortedImages()?.first?.url ?? String()
        
        productImageView.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        productImageView.sd_setImage(with: URL(string: imageUrl))
    }

    
    private func setupShadow() {
        backgroundColor = .white
        layer.cornerRadius = 12
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .init(width: 1, height: 2)
        layer.shadowOpacity = 0.2
    }
}

extension ProductCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(productImageView)
        productImageView.addSubview(favoriteButton)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(valueTitleLabel)
        contentView.addSubview(productInfoStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productImageView.heightAnchor.constraint(equalToConstant: 120),
            
            favoriteButton.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: -8),
            
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 16),
            productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            valueTitleLabel.topAnchor.constraint(greaterThanOrEqualTo: productNameLabel.topAnchor, constant: 8),
            valueTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            valueTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            productRateIcon.heightAnchor.constraint(equalToConstant: 16),
            productRateIcon.widthAnchor.constraint(equalToConstant: 16),
            
            productInfoStack.topAnchor.constraint(equalTo: valueTitleLabel.bottomAnchor, constant: 4),
            productInfoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            productInfoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            productInfoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func setupAdditionalConfiguration() {
        setupShadow()
    }
}
