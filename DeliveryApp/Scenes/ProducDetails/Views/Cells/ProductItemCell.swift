import UIKit

class ProductItemCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ProductItemCell.self)
    var plusButtonCellDidTapped: (() -> Void)?
    
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
        return imageView
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = makeLabel(
            font: Fonts.semiBold(size: 16).weight,
            color: .darkGray
        )
        return label
    }()
    
    lazy var plusButton: UIButton = {
        let button = UIButton(type:  .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.tintColor = Colors.primaryColor
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        let action = UIAction { [weak self] _ in
            self?.plusButtonCellDidTapped?()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    lazy var customStepper: CustomStepper = {
        let stepper = CustomStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.isHidden = false
        return stepper
    }()
    
    func configure(with viewData: ProductItemCellViewData, stepperValue: Int, isVisible: Bool) {
        productNameLabel.text = viewData.name
        productPriceLabel.text = viewData.price
        productImageView.sd_setImage(with: URL(string: viewData.image), placeholderImage: UIImage(systemName: "photo"))
        customStepper.plusButton.isEnabled = isVisible
        plusButton.isEnabled = isVisible
        customStepper.setValue(stepperValue)
        customStepper.isHidden = customStepper.getValue() == .zero ? true : false
    }

}

extension ProductItemCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(productNameLabel)
        contentView.addSubview(productImageView)
        contentView.addSubview(productPriceLabel)
        contentView.addSubview(plusButton)
        contentView.addSubview(customStepper)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            productNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            productNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            productImageView.centerYAnchor.constraint(equalTo: productNameLabel.centerYAnchor),
            productImageView.leadingAnchor.constraint(equalTo: productNameLabel.trailingAnchor, constant: 8),
            productImageView.heightAnchor.constraint(equalToConstant: 60),
            productImageView.widthAnchor.constraint(equalToConstant: 60),
            
            plusButton.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor),
            plusButton.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 8),
            productPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            productPriceLabel.trailingAnchor.constraint(equalTo: productImageView.leadingAnchor, constant: -8),
            productPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            
            customStepper.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            customStepper.trailingAnchor.constraint(equalTo: plusButton.trailingAnchor),
        ])
    }
}
