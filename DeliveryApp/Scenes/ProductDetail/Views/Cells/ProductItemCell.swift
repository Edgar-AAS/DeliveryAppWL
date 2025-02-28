import UIKit

class ProductItemCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ProductItemCell.self)
    var indexPath: IndexPath?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    weak var delegate: ProductItemCellDelegate?
    
    private var productPriceLabelBottomConstraint: NSLayoutConstraint?
    private var productNameLabelBottomConstraint: NSLayoutConstraint?
    
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
        imageView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 60).isActive = true
        return imageView
    }()
    
    private lazy var productPriceLabel: UILabel = {
        let label = makeLabel(
            font: Fonts.semiBold(size: 16).weight,
            color: .darkGray
        )
        return label
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type:  .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.tintColor = .primary1
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        let action = UIAction { [weak self] _ in
            self?.addTouchFeedback(style: .light)
            guard let self else { return }
            if let indexPath = self.indexPath {
                self.delegate?.productItemCell(self, didTapStepperWithAction: .add, at: indexPath)
            }
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private lazy var customStepper: DAStepper = {
        let stepper = DAStepper()
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.delegate = self
        return stepper
    }()
    
    func configure(with viewData: QuantitativeItemViewData, stepper: StepperModel, indexPath: IndexPath) {
        self.indexPath = indexPath
        
        productNameLabel.text = viewData.name
        productPriceLabel.text = viewData.price
        productImageView.sd_setImage(with: URL(string: viewData.image ?? ""))
        plusButton.isEnabled = stepper.isEnabled
        customStepper.isHidden = stepper.currentValue == .zero
        
        customStepper.configure(with: stepper)
            
        if viewData.isRemovable {
            productPriceLabel.isHidden = true
            productPriceLabelBottomConstraint?.isActive = false
            productNameLabelBottomConstraint?.isActive = true
        } else {
            productPriceLabel.isHidden = false
            productNameLabelBottomConstraint?.isActive = false
            productPriceLabelBottomConstraint?.isActive = true
        }
    }
}

extension ProductItemCell: CustomStepperDelegate {
    func customStepper(_ stepper: DAStepper, stepperDidTapped action: StepperActionType) {
        guard let indexPath = indexPath else { return }
        delegate?.productItemCell(self, didTapStepperWithAction: action, at: indexPath)
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
            
            plusButton.centerYAnchor.constraint(equalTo: productImageView.centerYAnchor),
            plusButton.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 8),
            plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            productPriceLabel.topAnchor.constraint(equalTo: productNameLabel.bottomAnchor, constant: 8),
            productPriceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            productPriceLabel.trailingAnchor.constraint(equalTo: productImageView.leadingAnchor, constant: -8),
            
            customStepper.centerYAnchor.constraint(equalTo: plusButton.centerYAnchor),
            customStepper.trailingAnchor.constraint(equalTo: plusButton.trailingAnchor),
        ])
        
        productNameLabelBottomConstraint = productNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        productPriceLabelBottomConstraint = productPriceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
    }
    
    func setupAdditionalConfiguration() {
        selectionStyle = .none
        backgroundColor = .white
        customStepper.backgroundColor = .white
        customStepper.layer.cornerRadius = 8
        customStepper.layer.shadowColor = UIColor.black.cgColor
        customStepper.layer.shadowOffset = .init(width: 1, height: 2)
        customStepper.layer.shadowOpacity = 0.2
    }
}
