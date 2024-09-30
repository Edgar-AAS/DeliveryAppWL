import UIKit

class CategoryCell: UICollectionViewCell {
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
        color: Colors.descriptionTextColor,
        textAlignment: .center
    )
        
    func selectedStyle() {
        backgroundColor = Colors.primaryColor
        categoryNameLabel.textColor = .white
    }
    
    func deselectedStyle() {
        backgroundColor = .white
        categoryNameLabel.textColor = Colors.descriptionTextColor
    }
    
    func setup(viewData: CategoryViewData) {
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
    
    func setupAddiotionalConfiguration() {
        backgroundColor = .white
        layer.cornerRadius = 8
    }
}
