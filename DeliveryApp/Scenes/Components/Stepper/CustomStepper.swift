import UIKit

protocol CustomStepperDelegate: AnyObject {
    func customStepper(_ stepper: CustomStepper, stepperDidTapped action: StepperActionType)
}

class CustomStepper: UIView {
    private var value: Int = 0 {
        didSet {
            valueLabel.text = "\(value)"
        }
    }
    
    private var stepperSize: StepperSize = .medium
    
    init(size: StepperSize = .medium) {
        self.stepperSize = size
        super.init(frame: .zero)
        setupView()
        updateSizeConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    weak var delegate: CustomStepperDelegate?
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.tintColor = Colors.primary
        
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.addTouchFeedback(style: .light)
            self.delegate?.customStepper(self, stepperDidTapped: .add)
        }
        
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.tintColor = Colors.primary
        
        let action = UIAction { [weak self] _ in
            guard let self else { return }
            self.addTouchFeedback(style: .light)
            self.delegate?.customStepper(self, stepperDidTapped: .remove)
        }
        
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    func configure(with dto: StepperModel) {
        minusButton.isEnabled = dto.currentValue > dto.minValue
        plusButton.isEnabled = dto.isEnabled
        
        setValue(dto.currentValue, animated: dto.isAnimated)
    }
    
    private func updateSizeConstraints() {
        let buttonSize = stepperSize.buttonSize
        let fontSize = stepperSize.fontSize
        let labelSize = stepperSize.labelSize
        
        NSLayoutConstraint.activate([
            minusButton.heightAnchor.constraint(equalToConstant: buttonSize),
            minusButton.widthAnchor.constraint(equalToConstant: buttonSize),
            plusButton.heightAnchor.constraint(equalToConstant: buttonSize),
            plusButton.widthAnchor.constraint(equalToConstant: buttonSize),
            
            valueLabel.widthAnchor.constraint(equalToConstant: labelSize),
            valueLabel.heightAnchor.constraint(equalToConstant: labelSize)
        ])
        
        valueLabel.font = Fonts.medium(size: fontSize).weight
    }
    
    private func setValue(_ newValue: Int, animated: Bool = true) {
        if animated {
            UIView.transition(with: valueLabel, duration: 0.1, options: .curveLinear, animations: {
                self.value = newValue
            })
        } else {
            value = newValue
        }
    }
}

extension CustomStepper: CodeView {
    func buildViewHierarchy() {
        addSubview(minusButton)
        addSubview(valueLabel)
        addSubview(plusButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            minusButton.topAnchor.constraint(equalTo: topAnchor),
            minusButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            minusButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            valueLabel.leadingAnchor.constraint(equalTo: minusButton.trailingAnchor, constant: 8),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            plusButton.topAnchor.constraint(equalTo: topAnchor),
            plusButton.leadingAnchor.constraint(equalTo: valueLabel.trailingAnchor, constant: 8),
            plusButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            plusButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
