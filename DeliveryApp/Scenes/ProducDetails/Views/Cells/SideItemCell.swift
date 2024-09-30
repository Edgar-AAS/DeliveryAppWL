import UIKit

class SideItemCell: UITableViewCell {
    static let reuseIdentifier = String(describing: SideItemCell.self)
    var sideItemDidSelected: (() -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var productNameLabel: UILabel = {
        let label = makeLabel(
            font: Fonts.regular(size: 16).weight,
            color: .black,
            numberOfLines: 0
        )
        return label
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = makeLabel(
            font: Fonts.semiBold(size: 16).weight,
            color: .darkGray
        )
        return label
    }()
    
    private lazy var radioButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "radio_unchecked"), for: .normal)
        button.setImage(UIImage(named: "radio_checked"), for: .selected)
        button.addAction(UIAction { [weak self] _ in
            self?.sideItemDidSelected?()
        }, for: .touchUpInside)
        return button
    }()
    
    func configure(with viewData: SideItemCellViewData) {
        productNameLabel.text = viewData.name
        productPriceLabel.text = viewData.price
        radioButton.isSelected = viewData.isSelected
        productImageView.sd_setImage(with: URL(string: viewData.image))
    }
}

extension SideItemCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productImageView)
        contentView.addSubview(productPriceLabel)
        contentView.addSubview(radioButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            productImageView.centerYAnchor.constraint(equalTo: productNameLabel.centerYAnchor),
            productImageView.leadingAnchor.constraint(equalTo: productNameLabel.trailingAnchor, constant: 8),
            productImageView.heightAnchor.constraint(equalToConstant: 60),
            productImageView.widthAnchor.constraint(equalToConstant: 60),
            
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 8),
            productPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            productPriceLabel.trailingAnchor.constraint(equalTo: productImageView.leadingAnchor, constant: -8),
            productPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
            radioButton.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor),
            radioButton.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            radioButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            radioButton.heightAnchor.constraint(equalToConstant: 30),
            radioButton.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
}
