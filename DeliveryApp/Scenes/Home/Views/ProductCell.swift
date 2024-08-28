//
//  ProductCell.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 30/04/24.
//

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
    
    private lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.widthAnchor.constraint(equalToConstant: 44).isActive = true
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .red
        button.layer.cornerRadius = 22
        button.backgroundColor = .white
        return button
    }()
    
    private lazy var foodNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.medium(size: 16).weight
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var foodRateImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.tintColor = Colors.primaryColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var foodRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.medium(size: 12).weight
        label.textColor = .black
        return label
    }()
    
    private lazy var distanceIcon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "location.north.circle.fill"))
        imageView.tintColor = Colors.primaryColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 16).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        return imageView
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.medium(size: 12).weight
        label.textColor = .black
        return label
    }()
    
    private lazy var productInfoStack = makeStackView(with: [foodRateImageView,
                                                             foodRateLabel,
                                                             UIView(),
                                                             distanceIcon,
                                                             distanceLabel
                                                            ],
                                                      spacing: 4,
                                                      axis: .horizontal)
    
    private lazy var foodPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.bold(size: 16).weight
        label.textColor = Colors.primaryColor
        return label
    }()
    
    func setup(viewModel: ProductCellViewModel) {
        let favoriteImage = UIImage(systemName: viewModel.getFavoriteImageString)
        favoriteButton.setImage(favoriteImage, for: .normal)
        foodNameLabel.text = viewModel.getName
        foodRateLabel.text = viewModel.getRate
        foodPriceLabel.text = viewModel.getformattedPrice
        distanceLabel.text = viewModel.getFormattedDistance
        foodImageView.sd_setImage(with: URL(string: viewModel.getFoodImage))
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
        contentView.addSubview(foodImageView)
        foodImageView.addSubview(favoriteButton)
        contentView.addSubview(foodNameLabel)
        contentView.addSubview(productInfoStack)
        contentView.addSubview(foodPriceLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            foodImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            foodImageView.heightAnchor.constraint(equalToConstant: 120),
            
            favoriteButton.topAnchor.constraint(equalTo: foodImageView.topAnchor, constant: 8),
            favoriteButton.trailingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: -8),
            
            foodNameLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 8),
            foodNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            foodNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            productInfoStack.topAnchor.constraint(lessThanOrEqualTo: foodNameLabel.bottomAnchor, constant: 8),
            productInfoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            productInfoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            foodPriceLabel.topAnchor.constraint(equalTo: productInfoStack.bottomAnchor, constant: 8),
            foodPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            foodPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            foodPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
    }
    
    func setupAddiotionalConfiguration() {
        setupShadow()
    }
}
