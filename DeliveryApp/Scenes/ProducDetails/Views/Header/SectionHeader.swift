import UIKit

final class SectionHeaderCell: UITableViewHeaderFooterView {
    static let reuseIdentifier = String(describing: SectionHeaderCell.self)
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var sectionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.font = Fonts.semiBold(size: 21).weight
        return label
    }()
    
    private lazy var optionsLimitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = Fonts.regular(size: 16).weight
        return label
    }()
    
    private lazy var requiredLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.isHidden = false
        label.layer.cornerRadius = 12
        label.font = Fonts.regular(size: 14).weight
        return label
    }()
    
    private lazy var feedbackOptionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        return imageView
    }()
    
    func configure(with viewData: SectionHeaderViewData) {
        sectionNameLabel.text = viewData.name
        optionsLimitLabel.text = viewData.limitOptions
    }
}



extension SectionHeaderCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(sectionNameLabel)
        contentView.addSubview(optionsLimitLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            sectionNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            sectionNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            sectionNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            
            optionsLimitLabel.topAnchor.constraint(equalTo: sectionNameLabel.bottomAnchor, constant: 4),
            optionsLimitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            optionsLimitLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            optionsLimitLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func setupAdditionalConfiguration() {
        contentView.backgroundColor = UIColor(hexString: "EFF2F5")
    }
}
