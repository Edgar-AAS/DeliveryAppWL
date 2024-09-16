import UIKit

protocol ProductCategorieCellDelegate: AnyObject {
    func productCategoryDidTapped(categoryId: Int)
}

class ProductCategorieCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ProductCategorieCell.self)
    private var categories: [ProductCategory] = []
    private var selectedIndex: IndexPath?
    
    weak var delegate: ProductCategorieCellDelegate?
    
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
    
    func setup(categories: [ProductCategory]) {
        self.categories = categories
        categoryCollectionView.reloadData()
    }
}

extension ProductCategorieCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}

extension ProductCategorieCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.reuseIdentifier, for: indexPath) as? CategoryCell
    
        if indexPath == IndexPath(item: .zero, section: .zero) {
            cell?.selectedStyle()
        }
        cell?.setup(viewModel: CategoryViewModel(category: categories[indexPath.item]))
        return cell ?? UICollectionViewCell()
    }
}

extension ProductCategorieCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? CategoryCell {
            cell.selectedStyle()
            
            if let previousIndex = selectedIndex, previousIndex != indexPath {
                if let previousCell = collectionView.cellForItem(at: previousIndex) as? CategoryCell {
                    previousCell.deselectedStyle()
                }
            }
            
            selectedIndex = indexPath
            delegate?.productCategoryDidTapped(categoryId: categories[indexPath.item].id)
        }
    }
}

extension ProductCategorieCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(categoryCollectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryCollectionView.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            categoryCollectionView.heightAnchor.constraint(equalToConstant: 85),
            categoryCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupAddiotionalConfiguration() {
        backgroundColor = .clear
    }
}

