import UIKit

final class ProductCategoryCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ProductCategoryCell.self)
    private var categories: [HomeViewData.CategoryCell] = []
    private var selectedIndex: IndexPath?
    
    weak var delegate: ProductCategoryCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectedIndex = IndexPath(item: .zero, section: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = .init(width: 65, height: 70)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.contentInset = .init(top: 0, left: 24, bottom: 0, right: 24)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.reuseIdentifier)
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .init(width: 1, height: 2)
        layer.shadowOpacity = 0.2
    }
    
    func configure(with categories: [HomeViewData.CategoryCell]) {
        self.categories = categories
        categoryCollectionView.reloadData()
    }
}

extension ProductCategoryCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}

extension ProductCategoryCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as? CategoryCell
    
        if indexPath == IndexPath(item: .zero, section: .zero) {
            cell?.selectedStyle()
        }
        
        let viewData = categories[indexPath.item]
        cell?.configure(with: viewData)
        return cell ?? UICollectionViewCell()
    }
}

extension ProductCategoryCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        addTouchFeedback(style: .light)
        
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
            cell.selectedStyle()
            
            if let previousIndex = selectedIndex, previousIndex != indexPath {
                if let previousCell = collectionView.cellForItem(at: previousIndex) as? CategoryCell {
                    previousCell.deselectedStyle()
                }
            }
            
            selectedIndex = indexPath
            
            let categoryId = categories[indexPath.item].id
            delegate?.productCategoryCell(self, didTapCategoryWithId: categoryId)
        }
    }
}

extension ProductCategoryCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(categoryCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            categoryCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 85),
            categoryCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}

