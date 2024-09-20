import UIKit

final class HeaderView: UIView {
    private let menuButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(systemName: "line.horizontal.3")
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.backgroundColor = UIColor(white: 0.9, alpha: 1)
        button.layer.cornerRadius = 25
        button.layer.masksToBounds = true
        return button
    }()
    
    private lazy var locationLabel = makeLabel(
        text: "ENTREGAR EM",
        font: Fonts.medium(size: 14).weight,
        color: Colors.primaryColor
    )
    
    private let locationButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Rua Timor leste, 827", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = Fonts.regular(size: 14).weight
        button.setImage(UIImage(named: "arrow_down"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .clear
        button.semanticContentAttribute = .forceRightToLeft
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        return button
    }()

    private let cartButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "cart"), for: .normal)
        button.tintColor = .black
        return button
    }()
    
    private let notificationBadge: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2"
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.backgroundColor = .orange
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        return label
    }()
    
    private lazy var searchDishesTextField: CustomSearchTextField = {
        let texField = CustomSearchTextField()
        texField.translatesAutoresizingMaskIntoConstraints = false
        return texField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension HeaderView: CodeView {
    func buildViewHierarchy() {
        addSubview(menuButton)
        addSubview(locationLabel)
        addSubview(locationButton)
        addSubview(searchDishesTextField)
        addSubview(cartButton)
        addSubview(notificationBadge)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            menuButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            menuButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            menuButton.widthAnchor.constraint(equalToConstant: 50),
            menuButton.heightAnchor.constraint(equalToConstant: 50),
            
            locationLabel.leadingAnchor.constraint(equalTo: menuButton.trailingAnchor, constant: 16),
            locationLabel.centerYAnchor.constraint(equalTo: menuButton.centerYAnchor, constant: -10),

            locationButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 4),
            locationButton.leadingAnchor.constraint(equalTo: locationLabel.leadingAnchor),
            locationButton.trailingAnchor.constraint(lessThanOrEqualTo: cartButton.leadingAnchor, constant: 24),
            
            cartButton.centerYAnchor.constraint(equalTo: locationLabel.centerYAnchor),
            cartButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            cartButton.widthAnchor.constraint(equalToConstant: 35),
            cartButton.heightAnchor.constraint(equalToConstant: 35),
            
            searchDishesTextField.topAnchor.constraint(equalTo: locationButton.bottomAnchor, constant: 24),
            searchDishesTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            searchDishesTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            searchDishesTextField.heightAnchor.constraint(equalToConstant: 60),
            searchDishesTextField.bottomAnchor.constraint(equalTo: bottomAnchor),
        
            notificationBadge.topAnchor.constraint(equalTo: cartButton.topAnchor, constant: -4),
            notificationBadge.trailingAnchor.constraint(equalTo: cartButton.trailingAnchor, constant: 4),
            notificationBadge.widthAnchor.constraint(equalToConstant: 20),
            notificationBadge.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
}
