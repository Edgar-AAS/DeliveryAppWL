import UIKit

final class ProductQuantityFooterView: UIView {
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
    
    private lazy var customStepper: DAStepper = {
        let stepper = DAStepper(size: .large)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.delegate = self
        stepper.layer.borderColor = UIColor.lightGray.cgColor
        stepper.layer.borderWidth = 1
        stepper.layer.cornerRadius = 8
        return stepper
    }()
    
    private lazy var addToCartButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 8
        button.backgroundColor = .primary1
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
    
    func configureTotalAmount(animateInfo: ValueAnimateInfo) {
        animateValueIncrement(fromValue: animateInfo.fromValue, toValue: animateInfo.toValue)
    }
    
    func configureButtonState(status: OptionsStatusType) {
        let isRequiredOptionsSelect = status == .done
        addToCartButton.isEnabled = isRequiredOptionsSelect
        addToCartButton.backgroundColor = isRequiredOptionsSelect ? .primary1 : Colors.inactiveButton
    }
    
    func configureStepper(with dto: StepperModel) {
        customStepper.configure(with: dto)
    }
}

extension ProductQuantityFooterView: CustomStepperDelegate {
    func customStepper(_ stepper: DAStepper, stepperDidTapped action: StepperActionType) {
        delegate?.productQuantityFooterView(self, didTapStepperWithAction: action)
    }
}

extension ProductQuantityFooterView {
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

extension ProductQuantityFooterView: CodeView {
    func buildViewHierarchy() {
        addSubview(customStepper)
        addSubview(addToCartButton)
        addToCartButton.addSubview(valueLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            customStepper.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
            customStepper.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            
            addToCartButton.centerYAnchor.constraint(equalTo: customStepper.centerYAnchor),
            addToCartButton.heightAnchor.constraint(equalTo: customStepper.heightAnchor),
            addToCartButton.leadingAnchor.constraint(equalTo: customStepper.trailingAnchor, constant: 16),
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
