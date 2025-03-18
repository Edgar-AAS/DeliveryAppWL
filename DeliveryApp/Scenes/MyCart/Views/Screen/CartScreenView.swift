//
//  CartScreenView.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 18/03/25.
//

import UIKit

final class CartScreenView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "My Cart"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let cartTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CartItemCell.self, forCellReuseIdentifier: CartItemCell.reuseIdentifier)
        return tableView
    }()
    
    private let recommendedLabel: UILabel = {
        let label = UILabel()
        label.text = "Recommended For You"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("See All", for: .normal)
        button.setTitleColor(.systemOrange, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let recommendedCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 190)
        layout.minimumLineSpacing = 12
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(RecommendedItemCell.self, forCellWithReuseIdentifier: RecommendedItemCell.reuseIdentifier)
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func setupCollectionViewProtocols(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
        recommendedCollectionView.delegate = delegate
        recommendedCollectionView.dataSource = dataSource
    }
    
    func setupTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        cartTableView.delegate = delegate
        cartTableView.dataSource = dataSource
    }
}

extension CartScreenView: CodeView {
    func buildViewHierarchy() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(moreButton)
        addSubview(cartTableView)
        addSubview(recommendedLabel)
        addSubview(seeAllButton)
        addSubview(recommendedCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            moreButton.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            moreButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            moreButton.widthAnchor.constraint(equalToConstant: 30),
            moreButton.heightAnchor.constraint(equalToConstant: 30),
            
            cartTableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            cartTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            cartTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            cartTableView.heightAnchor.constraint(equalToConstant: 300),
            
            recommendedLabel.topAnchor.constraint(equalTo: cartTableView.bottomAnchor, constant: 16),
            recommendedLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            seeAllButton.centerYAnchor.constraint(equalTo: recommendedLabel.centerYAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            recommendedCollectionView.topAnchor.constraint(equalTo: recommendedLabel.bottomAnchor, constant: 10),
            recommendedCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            recommendedCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            recommendedCollectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}
