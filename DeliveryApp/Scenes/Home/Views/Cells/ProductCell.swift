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
        button.layer.masksToBounds = true
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var productNameLabel: UILabel = {
        let label = makeLabel(
            font: Fonts.medium(size: 16).weight,
            color: .black)
        label.adjustsFontSizeToFitWidth = true
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
    
    private lazy var productInfoStack = makeStackView(with: [productRateIcon,
                                                             productRateLabel,
                                                             UIView()],
                                                      spacing: 4,
                                                      axis: .horizontal)
    
    
    private lazy var productPriceLabel = makeLabel(
        font: Fonts.bold(size: 16).weight,
        color: .black
    )
    
    func setup(viewData: ProductCellViewData) {
        productNameLabel.text = viewData.name
        productPriceLabel.text = viewData.price
        productRateLabel.text = viewData.rating
        favoriteButton.imageView?.image = viewData
            .isFavorite ? UIImage(systemName: "heart.fill")
                        : UIImage(systemName: "heart")
        
        if let image = viewData.getUrlImages()?.first {
            productImageView.sd_setImage(with: URL(string: image.url))
        } else {
            productImageView.image = UIImage(systemName: "photo")
        }
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
        contentView.addSubview(productInfoStack)
        contentView.addSubview(productPriceLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            productImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            productImageView.heightAnchor.constraint(equalToConstant: 120),
            
            favoriteButton.topAnchor.constraint(equalTo: productImageView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: -8),
            
            productNameLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 8),
            productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            productNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            productRateIcon.heightAnchor.constraint(equalToConstant: 16),
            productRateIcon.widthAnchor.constraint(equalToConstant: 16),
            
            productInfoStack.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 8),
            productInfoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            productInfoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            productPriceLabel.topAnchor.constraint(equalTo: productInfoStack.bottomAnchor, constant: 8),
            productPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            productPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            productPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func setupAdditionalConfiguration() {
        setupShadow()
    }
}
