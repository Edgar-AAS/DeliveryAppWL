import UIKit

class SideItemCell: UITableViewCell {
    static let reuseIdentifier = String(describing: SideItemCell.self)
    
    private lazy var productNameLabel: UILabel = {
        let label = makeLabel(
            font: Fonts.regular(size: 16).weight,
            color: .black,
            numberOfLines: 0
        )
        return label
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = makeLabel(
            font: Fonts.semiBold(size: 16).weight,
            color: .darkGray
        )
        return label
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return imageView
    }()
    
    private lazy var radioButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "radio_unchecked"), for: .normal)
        button.setImage(UIImage(named: "radio_checked"), for: .selected)
        button.isUserInteractionEnabled = false
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [productNameLabel, productPriceLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [verticalStackView, productImageView, radioButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 16
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewData: SideItemCellViewData) {
        radioButton.isSelected = viewData.isSelected
        productNameLabel.text = viewData.name
        productPriceLabel.text = viewData.price
        productImageView.sd_setImage(with: URL(string: viewData.image ?? ""))
    }
}

extension SideItemCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(horizontalStackView)
    }
    
    func setupConstraints() {
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func setupAdditionalConfiguration() {
        selectionStyle = .none
        backgroundColor = .white
    }
}
