import UIKit

final class ProductPriceFooter: UIView {
    private var displayLink: CADisplayLink?
    private var animationStartValue: Double = 0
    private var animationEndValue: Double = 0
    private var animationStartTime: CFTimeInterval = 0
    private let animationDuration: TimeInterval = 0.5
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    weak var delegate: ProductQuantityFooterViewDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private lazy var stepperContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 8
        return view
    }()
    
    private lazy var incrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.tintColor = .primary1
        
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.addTouchFeedback(style: .light)
            delegate?.stepperDidChange(self, action: .add)
        }
        
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private lazy var decrementButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.tintColor = .primary1
        
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.addTouchFeedback(style: .light)
            delegate?.stepperDidChange(self, action: .remove)
        }
        
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private lazy var quantityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.backgroundColor = Colors.inactiveButton
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.bold(size: 16).weight
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupShadow()
    }
    
    func updateValue(with footerModel: FooterStepperModel) {
        quantityLabel.text = "\(footerModel.currentValue)"
        decrementButton.isEnabled = footerModel.currentValue > footerModel.minValue
    }
    
    func configureTotalAmount(animateInfo: ProductAAmountModel) {
        animateValueIncrement(fromValue: animateInfo.fromValue, toValue: animateInfo.toValue)
    }
    
    func configureButtonState(status: OptionsStatusType) {
        let isRequiredOptionsSelect = status == .done
        addToCartButton.isEnabled = isRequiredOptionsSelect
        addToCartButton.backgroundColor = isRequiredOptionsSelect ? .primary1 : Colors.inactiveButton
    }
}

extension ProductPriceFooter {
    private func animateValueIncrement(fromValue: Double, toValue: Double) {
        animationStartValue = fromValue
        animationEndValue = toValue
        animationStartTime = CACurrentMediaTime()
        
        displayLink?.invalidate()
        
        displayLink = CADisplayLink(target: self, selector: #selector(updateValueLabel))
        displayLink?.add(to: .main, forMode: .common)
    }
    
    @objc private func updateValueLabel() {
        guard let displayLink = displayLink else { return }
        
        let elapsedTime = CACurrentMediaTime() - animationStartTime
        let progress = min(elapsedTime / animationDuration, 1.0)
        
        let currentValue = animationStartValue + (progress * (animationEndValue - animationStartValue))
        valueLabel.text = "Adicionar: \(currentValue.format(with: .currency))"
        
        if progress >= 1.0 {
            displayLink.invalidate()
            self.displayLink = nil
        }
    }
    
    private func setupShadow() {
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: -3)
        layer.shadowOpacity = 0.1
        
        let shadowPath = UIBezierPath(
            roundedRect: bounds,
            cornerRadius: layer.cornerRadius
        )
        
        layer.shadowPath = shadowPath.cgPath
    }
}

extension ProductPriceFooter: CodeView {
    func buildViewHierarchy() {
        addSubview(stepperContainer)
        stepperContainer.addSubview(decrementButton)
        stepperContainer.addSubview(quantityLabel)
        stepperContainer.addSubview(incrementButton)
        addSubview(addToCartButton)
        addToCartButton.addSubview(valueLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stepperContainer.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            stepperContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stepperContainer.heightAnchor.constraint(equalToConstant: 50),
            stepperContainer.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
            
            decrementButton.topAnchor.constraint(equalTo: stepperContainer.topAnchor),
            decrementButton.leadingAnchor.constraint(equalTo: stepperContainer.leadingAnchor),
            decrementButton.widthAnchor.constraint(equalTo: stepperContainer.heightAnchor),
            decrementButton.bottomAnchor.constraint(equalTo: stepperContainer.bottomAnchor),
            
            quantityLabel.leadingAnchor.constraint(equalTo: decrementButton.trailingAnchor, constant: 8),
            quantityLabel.centerYAnchor.constraint(equalTo: stepperContainer.centerYAnchor),
            
            incrementButton.topAnchor.constraint(equalTo: stepperContainer.topAnchor),
            incrementButton.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor, constant: 8),
            incrementButton.widthAnchor.constraint(equalTo: stepperContainer.heightAnchor),
            incrementButton.trailingAnchor.constraint(equalTo: stepperContainer.trailingAnchor),
            incrementButton.bottomAnchor.constraint(equalTo: stepperContainer.bottomAnchor),
            
            addToCartButton.centerYAnchor.constraint(equalTo: stepperContainer.centerYAnchor),
            addToCartButton.heightAnchor.constraint(equalTo: stepperContainer.heightAnchor),
            addToCartButton.leadingAnchor.constraint(equalTo: stepperContainer.trailingAnchor, constant: 16),
            addToCartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            
            valueLabel.topAnchor.constraint(equalTo: addToCartButton.topAnchor),
            valueLabel.leadingAnchor.constraint(equalTo: addToCartButton.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: addToCartButton.trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: addToCartButton.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .white
    }
}
