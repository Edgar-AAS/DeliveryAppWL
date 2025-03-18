//
//  RecommendedItemCell.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 18/03/25.
//
import UIKit

final class RecommendedItemCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: RecommendedItemCell.self)
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .green
        imageView.layer.cornerRadius = 12
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ratingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.fill")
        imageView.tintColor = .systemOrange
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let distanceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "location.fill")
        imageView.tintColor = .systemOrange
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .systemOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: RecommendedItem) {
        nameLabel.text = item.name
        ratingLabel.text = "\(item.rating)"
        distanceLabel.text = item.distance
        priceLabel.text = "$ \(item.price)"
        imageView.image = item.image
    }
}

extension RecommendedItemCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(ratingImageView)
        containerView.addSubview(ratingLabel)
        containerView.addSubview(distanceImageView)
        containerView.addSubview(distanceLabel)
        containerView.addSubview(priceLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            nameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            ratingImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            ratingImageView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ratingImageView.widthAnchor.constraint(equalToConstant: 14),
            ratingImageView.heightAnchor.constraint(equalToConstant: 14),
            
            ratingLabel.leadingAnchor.constraint(equalTo: ratingImageView.trailingAnchor, constant: 4),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingImageView.centerYAnchor),
            
            distanceImageView.centerYAnchor.constraint(equalTo: ratingImageView.centerYAnchor),
            distanceImageView.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 8),
            distanceImageView.widthAnchor.constraint(equalToConstant: 14),
            distanceImageView.heightAnchor.constraint(equalToConstant: 14),
            
            distanceLabel.leadingAnchor.constraint(equalTo: distanceImageView.trailingAnchor, constant: 4),
            distanceLabel.centerYAnchor.constraint(equalTo: distanceImageView.centerYAnchor),
            
            priceLabel.topAnchor.constraint(equalTo: ratingImageView.bottomAnchor, constant: 8),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -8)
        ])
    }
}
