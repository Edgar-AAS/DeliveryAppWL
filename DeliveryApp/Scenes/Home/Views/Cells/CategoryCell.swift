import UIKit

final class CategoryCell: UICollectionViewCell {
    static let reuseIdentifier = String(describing: CategoryCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var categoryIconImageView = makeImageView()
    
    private lazy var categoryNameLabel = makeLabel(
        font: Fonts.semiBold(size: 12).weight,
        color: Colors.descriptionText,
        textAlignment: .center
    )
        
    func selectedStyle() {
        backgroundColor = .primary1
        categoryNameLabel.textColor = .white
    }
    
    func deselectedStyle() {
        backgroundColor = .white
        categoryNameLabel.textColor = Colors.descriptionText
    }
    
    func configure(with viewData: CategoryCellViewData) {
        categoryNameLabel.text = viewData.name
        
        if let image = viewData.image, let imageUrl = URL(string: image) {
            categoryIconImageView.sd_setImage(with: imageUrl)
        } else {
            categoryIconImageView.sd_setImage(with: nil, placeholderImage: UIImage(systemName: "photo"))
        }
    }
}

extension CategoryCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(categoryIconImageView)
        contentView.addSubview(categoryNameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            categoryIconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryIconImageView.heightAnchor.constraint(equalToConstant: 24),
            categoryIconImageView.widthAnchor.constraint(equalToConstant: 24),
            
            categoryNameLabel.topAnchor.constraint(equalTo: categoryIconImageView.bottomAnchor, constant: 4),
            categoryNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            categoryNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            categoryNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
        layer.cornerRadius = 8
    }
}
