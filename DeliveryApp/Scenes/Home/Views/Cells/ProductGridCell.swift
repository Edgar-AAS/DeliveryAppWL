import UIKit

protocol ProductGridCellDelegate: AnyObject {
    func productCardDidTapped(productSelected: Product)
    func fetchProductsIfNeeded(categoryId: Int)
}

class ProductGridCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ProductGridCell.self)
    private var products: [Product] = []
    private var currentCategoryId: Int?
    private var debounceTimer: Timer?
    
    weak var delegate: ProductGridCellDelegate?
    
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
        collectionView.contentInset = .init(top: 10, left: 24, bottom: 48, right: 24)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.reuseIdentifier)
        return collectionView
    }()
    
    func loadProducts(dataSource: ProductGridCellDataSource) {
        self.products = dataSource.products
        self.currentCategoryId = dataSource.categoryId
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
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}

extension ProductGridCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedProduct = products[indexPath.item]
        delegate?.productCardDidTapped(productSelected: selectedProduct)
    }
}

extension ProductGridCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.reuseIdentifier, for: indexPath) as? ProductCell
        let product = products[indexPath.item]
        cell?.setup(viewData: ProductCellViewData(product: product))
        return cell ?? UICollectionViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        let offsetY = scrollView.contentOffset.y
        
        if offsetY > contentHeight - scrollViewHeight * 2 {
            debounceTimer?.invalidate()
            
            debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false) { [weak self] _ in
                guard let self = self else { return }
                if let categoryId = self.currentCategoryId {
                    self.delegate?.fetchProductsIfNeeded(categoryId: categoryId)
                }
            }
        }
    }
}

extension ProductGridCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: collectionView.frame.size.width / 2.4, height: 240)
    }
}
