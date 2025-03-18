import UIKit

final class SectionHeaderCell: UITableViewHeaderFooterView {
    static let reuseIdentifier = String(describing: SectionHeaderCell.self)
    
    private var requiredBackViewWidthConstraint: NSLayoutConstraint?
    
    private lazy var sectionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = Fonts.semiBold(size: 16).weight
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private lazy var optionsLimitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = Fonts.regular(size: 16).weight
        return label
    }()
    
    private lazy var requiredBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.backgroundColor = .black
        return view
    }()
    
    private lazy var requiredLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.font = Fonts.semiBold(size: 10).weight
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewData: ProductDetailViewData.SectionHeaderViewData) {
        sectionNameLabel.text = viewData.name
        optionsLimitLabel.text = viewData.sectionOptionsLimit
        requiredLabel.text = viewData.requiredText
        
        let isRequired = viewData.isRequired
    
        requiredBackView.isHidden = !isRequired
        requiredBackViewWidthConstraint?.isActive = isRequired
    }
}

extension SectionHeaderCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(sectionNameLabel)
        contentView.addSubview(optionsLimitLabel)
        contentView.addSubview(requiredBackView)
        requiredBackView.addSubview(requiredLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            sectionNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            sectionNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            
            requiredBackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 8),
            requiredBackView.leadingAnchor.constraint(equalTo: sectionNameLabel.trailingAnchor, constant: 8),
            requiredBackView.heightAnchor.constraint(equalToConstant: 25),
            
            requiredLabel.centerYAnchor.constraint(equalTo: requiredBackView.centerYAnchor),
            requiredLabel.leadingAnchor.constraint(equalTo: requiredBackView.leadingAnchor, constant: 8),
            requiredLabel.trailingAnchor.constraint(equalTo: requiredBackView.trailingAnchor, constant: -8),
                         
            optionsLimitLabel.topAnchor.constraint(equalTo: sectionNameLabel.bottomAnchor, constant: 4),
            optionsLimitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            optionsLimitLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            optionsLimitLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
        requiredBackViewWidthConstraint = requiredBackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24)
    }
    
    func setupAdditionalConfiguration() {
        contentView.backgroundColor = UIColor(hexString: "EFF2F5")
    }
}
