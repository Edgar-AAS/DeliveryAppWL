//
//  CategoryCell.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/04/24.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    struct CategoryViewModel {
        let image: String?
        let name: String
    }
    
    static let reuseIdentifier = String(describing: CategoryCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var categoryIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "category-burger") //vai vir do JSON
        return imageView
    }()
    
    lazy var categoryName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Burger"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont(name: "Inter-SemiBold", size: 12)
        return label
    }()
    
    func selectedStyle() {
        backgroundColor = .orange
        categoryName.textColor = .white
    }
    
    func deselectedStyle() {
        backgroundColor = .white
        categoryName.textColor = .black
    }
    
    func setup(viewModel: CategoryViewModel) {
        categoryName.text = viewModel.name
    }
}

extension CategoryCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(categoryIconImageView)
        contentView.addSubview(categoryName)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            categoryIconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryIconImageView.heightAnchor.constraint(equalToConstant: 24),
            categoryIconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            categoryName.topAnchor.constraint(equalTo: categoryIconImageView.bottomAnchor, constant: 4),
            categoryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            categoryName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            categoryName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func setupAddiotionalConfiguration() {
        backgroundColor = .white
        layer.cornerRadius = 8
        clipsToBounds = true
    }
}


