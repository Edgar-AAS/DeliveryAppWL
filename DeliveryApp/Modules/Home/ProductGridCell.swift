//
//  ProductCell.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/04/24.
//

import UIKit

protocol ProductGridCellDelegate: AnyObject {
    func foodCardDidTapped(foodSelected: Food)
}

class ProductGridCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ProductGridCell.self)
    private var foodData: [Food] = []
    
    weak var delegate: ProductGridCellDelegate?
    
    func reloadDataCallBack(fooData: [Food]) {
        self.foodData = fooData
        categoryCollectionView.reloadData()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = .init(top: 10, left: 24, bottom: 0, right: 24)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
        return collectionView
    }()
    
    func reloadGridData() {
        categoryCollectionView.reloadData()
    }
    
    func setup(foodData: [Food]) {
        self.foodData = foodData
        categoryCollectionView.reloadData()
    }
}

extension ProductGridCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(categoryCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupAddiotionalConfiguration() {
        backgroundColor = .clear
    }
}

extension ProductGridCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.foodCardDidTapped(foodSelected: foodData[indexPath.item])
    }
}

extension ProductGridCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as? ProductCell
        cell?.setup(food: foodData[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}

extension ProductGridCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.size.width / 2.4, height: 240)
    }
}
