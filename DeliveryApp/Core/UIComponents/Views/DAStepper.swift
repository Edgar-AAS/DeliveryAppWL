import UIKit

protocol CustomStepperDelegate: AnyObject {
    func customStepper(_ stepper: DAStepper, stepperDidTapped action: StepperActionType)
}

struct StepperModel {
    let currentValue: Int
    let minValue: Int
    let isEnabled: Bool
    let isAnimated: Bool
}

final class DAStepper: UIView {
    enum StepperSize {
        case small
        case medium
        case large
    }
    
    private var value: Int = 0 {
        didSet {
            valueLabel.text = "\(value)"
        }
    }
    
    private var stepperSize: StepperSize
    
    init(size: StepperSize = .medium) {
        self.stepperSize = size
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: CustomStepperDelegate?
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.tintColor = .primary1
        
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
        button.tintColor = .primary1
        
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
        var buttonSize: CGFloat = 0
        var fontSize: CGFloat = 0
        var labelSize: CGFloat = 0
        
        switch stepperSize {
            case .small:
                buttonSize = 24
                labelSize = 24
                fontSize = 12
            case .medium:
                buttonSize = 30
                labelSize = 20
                fontSize = 16
            case .large:
                buttonSize = 40
                labelSize = 30
                fontSize = 20
        }
               
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

extension DAStepper: CodeView {
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
    
    func setupAdditionalConfiguration() {
        updateSizeConstraints()
    }
}
