//
//  CartItemCell.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 18/03/25.
//
import UIKit

final class CartItemCell: UITableViewCell {
    static let reuseIdentifier = String(describing: CartItemCell.self)
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let checkboxButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "checkmark.square.fill"), for: .normal)
        button.tintColor = .systemOrange
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .yellow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textColor = .systemOrange
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let decrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("−", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let quantityLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("+", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.tintColor = .systemRed
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func configure(with item: CartItem) {
        nameLabel.text = item.name
        priceLabel.text = "$ \(item.price)"
        quantityLabel.text = "\(item.quantity)"
        itemImageView.image = item.image
    }
}

extension CartItemCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(containerView)
        containerView.addSubview(checkboxButton)
        containerView.addSubview(itemImageView)
        containerView.addSubview(nameLabel)
        containerView.addSubview(priceLabel)
        containerView.addSubview(decrementButton)
        containerView.addSubview(quantityLabel)
        containerView.addSubview(incrementButton)
        containerView.addSubview(deleteButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            checkboxButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            checkboxButton.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            checkboxButton.widthAnchor.constraint(equalToConstant: 24),
            checkboxButton.heightAnchor.constraint(equalToConstant: 24),
            
            itemImageView.leadingAnchor.constraint(equalTo: checkboxButton.trailingAnchor, constant: 12),
            itemImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            itemImageView.widthAnchor.constraint(equalToConstant: 80),
            itemImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.topAnchor.constraint(equalTo: itemImageView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            priceLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            priceLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            
            decrementButton.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            decrementButton.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 4),
            decrementButton.widthAnchor.constraint(equalToConstant: 30),
            decrementButton.heightAnchor.constraint(equalToConstant: 24),
            
            quantityLabel.leadingAnchor.constraint(equalTo: decrementButton.trailingAnchor),
            quantityLabel.centerYAnchor.constraint(equalTo: decrementButton.centerYAnchor),
            quantityLabel.widthAnchor.constraint(equalToConstant: 30),
            
            incrementButton.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor),
            incrementButton.centerYAnchor.constraint(equalTo: decrementButton.centerYAnchor),
            incrementButton.widthAnchor.constraint(equalToConstant: 30),
            incrementButton.heightAnchor.constraint(equalToConstant: 24),
            
            deleteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            deleteButton.centerYAnchor.constraint(equalTo: decrementButton.centerYAnchor),
            deleteButton.widthAnchor.constraint(equalToConstant: 24),
            deleteButton.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    func setupAdditionalConfiguration() {
        selectionStyle = .none
        backgroundColor = .white
    }
}
