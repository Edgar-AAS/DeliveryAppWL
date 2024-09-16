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
    
    private lazy var categoryIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "category-burger")
        return imageView
    }()
    
    lazy var categoryName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = Colors.descriptionTextColor
        label.font = Fonts.semiBold(size: 12).weight
        return label
    }()
    
    func selectedStyle() {
        backgroundColor = Colors.primaryColor
        categoryName.textColor = .white
    }
    
    func deselectedStyle() {
        backgroundColor = .white
        categoryName.textColor = Colors.descriptionTextColor
    }
    
    func setup(viewModel: CategoryViewModel) {
        categoryName.text = viewModel.name
        
        if let image = viewModel.image, let imageUrl = URL(string: image) {
            categoryIconImageView.sd_setImage(with: imageUrl)
        } else {
            categoryIconImageView.sd_setImage(with: nil, placeholderImage: UIImage(systemName: "photo"))
        }
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
    }
}
