import UIKit

class CustomStepper: UIView {
    private var value: Int = 0 {
        didSet {
            valueLabel.text = "\(value)"
        }
    }
    
    var plusButtonTapped: (() -> Void)?
    var minusButtonTapped: (() -> Void)?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    lazy var plusButton: UIButton = {
        let button = UIButton(type:  .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.tintColor = Colors.primaryColor
        
        let action = UIAction { [weak self] _ in
            self?.plusButtonTapped?()
        }
        
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    lazy var minusButton: UIButton = {
        let button = UIButton(type:  .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        button.tintColor = Colors.primaryColor
        
        let action = UIAction { [weak self] _ in
            self?.minusButtonTapped?()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    // MARK: - Setup View
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.regular(size: 16).weight
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    func setValue(_ newValue: Int, animated: Bool = true) {
        if animated {
            UIView.transition(with: valueLabel, duration: 0.1, options: .curveLinear, animations: {
                self.value = newValue
            })
        } else {
            value = newValue
        }
    }
    
    func getValue() -> Int {
        return value
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
    
    func setupAddiotionalConfiguration() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .init(width: 1, height: 2)
        layer.shadowOpacity = 0.2
    }
}
