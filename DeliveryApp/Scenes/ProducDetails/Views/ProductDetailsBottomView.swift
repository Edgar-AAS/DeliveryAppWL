import UIKit

protocol ProductDetailsScreenDelegate: AnyObject {
    func backButtonDidTapped(_ view: ProductDetailsBottomView)
    func favoriteButtonDidTapped(_ view: ProductDetailsBottomView)
}

class ProductDetailsBottomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.backgroundColor
        return view
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type:  .system)
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.tintColor = .black
        
        let action = UIAction { [weak self] _ in

        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type:  .system)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        let action = UIAction { [weak self] _ in
            
        }
        
        button.addAction(action, for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    private lazy var productQuantityLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.semiBold(size: 18).weight
        label.textColor = .black
        return label
    }()
    
    private lazy var foodStepperStack = makeStackView(with: [minusButton,
                                                             productQuantityLabel,
                                                             plusButton],
                                                      aligment: .center,
                                                      spacing: 20,
                                                      axis: .horizontal)
    
    private lazy var productTotalPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Colors.primaryColor
        label.font = Fonts.bold(size: 24).weight
        return label
    }()
    
    private lazy var addToCardButton: UIButton = {
        let button = UIButton(type:  .system)
        button.setTitle("Add to Cart", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = Fonts.bold(size: 14).weight
        button.setImage(UIImage(named: "cart"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.tintColor = .white
        button.layer.cornerRadius = 26
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.primaryColor
        return button
    }()
    
    func updateStepper() {
//        productTotalPrice.text = dto.amount
//        productQuantityLabel.text = dto.count
    }
}

extension ProductDetailsBottomView: CodeView {
    func buildViewHierarchy() {
        addSubview(bottomView)
        bottomView.addSubview(foodStepperStack)
        bottomView.addSubview(productTotalPrice)
        bottomView.addSubview(addToCardButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            bottomView.topAnchor.constraint(equalTo: topAnchor),
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            foodStepperStack.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 8),
            foodStepperStack.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 24),
            foodStepperStack.heightAnchor.constraint(equalToConstant: 44),
            
            productTotalPrice.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 8),
            productTotalPrice.leadingAnchor.constraint(greaterThanOrEqualTo: foodStepperStack.trailingAnchor, constant: 8),
            productTotalPrice.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -24),
            
            addToCardButton.topAnchor.constraint(equalTo: foodStepperStack.bottomAnchor, constant: 16),
            addToCardButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 24),
            addToCardButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -24),
            addToCardButton.heightAnchor.constraint(equalToConstant: 52),
            addToCardButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -48)
        ])
    }
}
