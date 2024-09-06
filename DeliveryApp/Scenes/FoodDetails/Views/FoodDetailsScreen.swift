import UIKit

protocol FoodDetailsScreenDelegate: AnyObject {
    func backButtonDidTapped()
    func minusButtonDidTapped()
    func plusButtonDidTapped()
    func favoriteButtonDidTapped()
}

class FoodDetailsScreen: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: FoodDetailsScreenDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = Colors.backgroundColor
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var foodNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = Fonts.semiBold(size: 24).weight
        return label
    }()
    
    private lazy var foodPriceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.bold(size: 18).weight
        label.textColor = Colors.primaryColor
        return label
    }()
    
    private lazy var foodBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = Colors.primaryColor.withAlphaComponent(0.04)
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    private lazy var dollarIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dollar")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var clockIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "clock")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var starIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var deliveryFeeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Free Delivery"
        label.font = Fonts.regular(size: 14).weight
        label.textColor = Colors.descriptionTextColor
        return label
    }()
    
    private lazy var deliveryTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.regular(size: 14).weight
        label.textColor = Colors.descriptionTextColor
        return label
    }()
    
    private lazy var foodRateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.regular(size: 14).weight
        label.textColor = Colors.descriptionTextColor
        return label
    }()
    
    private lazy var backButton: CircularButton = {
        let button = CircularButton(iconImage: .init(systemName: "arrow.left"), size: 36)
        button.layer.borderColor = UIColor.white.cgColor
        button.tintColor = .white
        button.layer.borderWidth = 1
        
        let action = UIAction { [weak self] _ in
            self?.delegate?.backButtonDidTapped()
        }
        
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private lazy var favoriteButton: CircularButton = {
        let button = CircularButton(iconImage: .init(systemName: "heart"), size: 36)
        button.layer.borderColor = UIColor.white.cgColor
        button.tintColor = .white
        
        let action = UIAction { [weak self] _ in
            self?.delegate?.favoriteButtonDidTapped()
        }
        button.addAction(action, for: .touchUpInside)
        button.layer.borderWidth = 1
        return button
    }()
    
    private lazy var topButtonStack = makeStackView(with: [backButton, favoriteButton],
                                                    aligment: .fill,
                                                    distribution: .equalSpacing,
                                                    spacing: 8,
                                                    axis: .horizontal)
    
    private lazy var deliveryFeeStack = makeStackView(with: [dollarIcon, deliveryFeeLabel],
                                                      spacing: 8,
                                                      axis: .horizontal)
    
    private lazy var deliveryTimeStack = makeStackView(with: [clockIcon, deliveryTimeLabel],
                                                       spacing: 8,
                                                       axis: .horizontal)
    
    private lazy var foodRateStack = makeStackView(with: [starIcon, foodRateLabel],
                                                   spacing: 8,
                                                   axis: .horizontal)
    
    
    private lazy var foodInformationHorizontalStack = makeStackView(with: [deliveryFeeStack,
                                                                           deliveryTimeStack,
                                                                           foodRateStack],
                                                                    distribution: .equalSpacing,
                                                                    spacing: 8,
                                                                    axis: .horizontal)
    
    private lazy var descriptionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Description"
        label.font = Fonts.semiBold(size: 16).weight
        label.textColor = .black
        return label
    }()
    
    private lazy var descriptionTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = Fonts.regular(size: 16).weight
        label.textColor = Colors.descriptionTextColor
        return label
    }()
    
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
            self?.delegate?.minusButtonDidTapped()
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
            self?.delegate?.plusButtonDidTapped()
        }
        button.addAction(action, for: .touchUpInside)
        button.tintColor = .black
        return button
    }()
    
    private lazy var foodQuantityLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.semiBold(size: 18).weight
        label.textColor = .black
        return label
    }()
    
    private lazy var foodStepperStack = makeStackView(with: [minusButton,
                                                             foodQuantityLabel,
                                                             plusButton],
                                                      aligment: .center,
                                                      spacing: 20,
                                                      axis: .horizontal)
    
    private lazy var foodTotalPriceLabel: UILabel = {
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
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = Colors.primaryColor
        return button
    }()
    
    func updateUI(with viewModel: FoodDetailsScreenDTO) {
        foodNameLabel.text = viewModel.title
        foodPriceLabel.text = viewModel.price
        deliveryFeeLabel.text = viewModel.deliveryFee
        deliveryTimeLabel.text = viewModel.estimatedDeliveryTime
        foodQuantityLabel.text = viewModel.quantity
        foodTotalPriceLabel.text = viewModel.price
        foodRateLabel.text = viewModel.rate
        descriptionTextLabel.text = viewModel.description
        updateFavoriteButtonState(viewModel.isFavorite)
        
        let placeholderImage = UIImage(systemName: "photo")
        foodImageView.sd_setImage(with: URL(string: viewModel.image),
                                  placeholderImage: placeholderImage)
    }
    
    func updateFavoriteButtonState(_ state: Bool) {
        favoriteButton.setImage(state ? UIImage(systemName: "heart.fill")
                                      : UIImage(systemName: "heart"), for: .normal)
    }
    
    func updateStepper(dto: StepperDTO) {
        foodTotalPriceLabel.text = dto.amount
        foodQuantityLabel.text = dto.count
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addToCardButton.layer.cornerRadius = addToCardButton.frame.height / 2
        addToCardButton.clipsToBounds = true
    }
}

extension FoodDetailsScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(foodImageView)
        foodImageView.addSubview(topButtonStack)
        
        containerView.addSubview(foodNameLabel)
        containerView.addSubview(foodPriceLabel)
        containerView.addSubview(foodBackgroundView)
        foodBackgroundView.addSubview(foodInformationHorizontalStack)
        containerView.addSubview(descriptionTitleLabel)
        containerView.addSubview(descriptionTextLabel)
        
        addSubview(bottomView)
        bottomView.addSubview(foodStepperStack)
        bottomView.addSubview(foodTotalPriceLabel)
        bottomView.addSubview(addToCardButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            foodImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            foodImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            foodImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            foodImageView.heightAnchor.constraint(equalToConstant: 360),
            
            topButtonStack.topAnchor.constraint(equalTo: foodImageView.topAnchor, constant: 16),
            topButtonStack.leadingAnchor.constraint(equalTo: foodImageView.leadingAnchor, constant: 16),
            topButtonStack.trailingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: -16),
            
            foodNameLabel.topAnchor.constraint(equalTo: foodImageView.bottomAnchor, constant: 16),
            foodNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            foodNameLabel.trailingAnchor.constraint(equalTo: foodImageView.trailingAnchor, constant: -16),
            
            foodPriceLabel.topAnchor.constraint(equalTo: foodNameLabel.bottomAnchor, constant: 8),
            foodPriceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            foodPriceLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            foodBackgroundView.topAnchor.constraint(equalTo: foodPriceLabel.bottomAnchor, constant: 16),
            foodBackgroundView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            foodBackgroundView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            foodBackgroundView.heightAnchor.constraint(equalToConstant: 40),
            
            foodInformationHorizontalStack.topAnchor.constraint(equalTo: foodBackgroundView.topAnchor),
            foodInformationHorizontalStack.leadingAnchor.constraint(equalTo: foodBackgroundView.leadingAnchor, constant: 8),
            foodInformationHorizontalStack.trailingAnchor.constraint(equalTo: foodBackgroundView.trailingAnchor, constant: -8),
            foodInformationHorizontalStack.bottomAnchor.constraint(equalTo: foodBackgroundView.bottomAnchor),
            
            descriptionTitleLabel.topAnchor.constraint(equalTo: foodBackgroundView.bottomAnchor, constant: 32),
            descriptionTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            descriptionTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            
            descriptionTextLabel.topAnchor.constraint(equalTo: descriptionTitleLabel.bottomAnchor, constant: 8),
            descriptionTextLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            descriptionTextLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            descriptionTextLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -140),
            
            bottomView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            foodStepperStack.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 8),
            foodStepperStack.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 24),
            foodStepperStack.heightAnchor.constraint(equalToConstant: 44),
            
            foodTotalPriceLabel.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 8),
            foodTotalPriceLabel.leadingAnchor.constraint(greaterThanOrEqualTo: foodStepperStack.trailingAnchor, constant: 8),
            foodTotalPriceLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -24),
            
            addToCardButton.topAnchor.constraint(equalTo: foodStepperStack.bottomAnchor, constant: 16),
            addToCardButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 24),
            addToCardButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -24),
            addToCardButton.heightAnchor.constraint(equalToConstant: 52),
            addToCardButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -48)
        ])
    }
}

