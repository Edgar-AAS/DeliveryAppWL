import UIKit

protocol CustomStepperDelegate: AnyObject {
    func updateStepper(action: StepperActionType)
}

struct StepperDTO {
    let currentValue: Int
    let minValue: Int
    let isEnabled: Bool
    let isAnimated: Bool
}

enum StepperSize {
    case small
    case medium
    case large
    
    var buttonSize: CGFloat {
        switch self {
        case .small:
            return 24
        case .medium:
            return 30
        case .large:
            return 40
        }
    }
    
    var labelSize: CGFloat {
        switch self {
        case .small:
            return buttonSize
        case .medium:
            return 20
        case .large:
            return 30
        }
    }
    
    var fontSize: CGFloat {
        switch self {
        case .small:
            return 12
        case .medium:
            return 16
        case .large:
            return 20
        }
    }
}

class CustomStepper: UIView {
    private var value: Int = 0 {
        didSet {
            valueLabel.text = "\(value)"
        }
    }
    
    private var stepperSize: StepperSize = .medium
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
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
            self?.delegate?.updateStepper(action: .add)
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
            self?.delegate?.updateStepper(action: .remove)
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
    
    func configure(with dto: StepperDTO, size: StepperSize) {
        stepperSize = size
        updateSizeConstraints()
        
        minusButton.isEnabled = dto.currentValue > dto.minValue
        plusButton.isEnabled = dto.isEnabled
        
        setValue(dto.currentValue, animated: dto.isAnimated)
    }
    
    private func updateSizeConstraints() {
        let buttonSize = stepperSize.buttonSize
        let fontSize = stepperSize.fontSize
        let labelSize = stepperSize.labelSize
        
        minusButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        minusButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        plusButton.heightAnchor.constraint(equalToConstant: buttonSize).isActive = true
        plusButton.widthAnchor.constraint(equalToConstant: buttonSize).isActive = true
        
        valueLabel.widthAnchor.constraint(equalToConstant: labelSize).isActive = true
        valueLabel.heightAnchor.constraint(equalToConstant: labelSize).isActive = true
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
