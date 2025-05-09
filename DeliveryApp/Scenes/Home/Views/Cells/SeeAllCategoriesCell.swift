import UIKit

final class SeeAllCategoriesCell: UITableViewCell {
    static let reuseIdentifier = String(describing: SeeAllCategoriesCell.self)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var findByCategoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Find by Category"
        label.textColor = .black
        label.font = Fonts.semiBold(size: 16).weight
        return label
    }()
    
    private lazy var seeAllButton = DATitleButton(
        title: "See All",
        titleColor: .primary1,
        font:  Fonts.bold(size: 14).weight,
        action: {}
    )

    private lazy var categoryLabelAndButtonStack = makeStackView(
        with: [findByCategoryLabel,
               seeAllButton],
        axis: .horizontal
    )
}

extension SeeAllCategoriesCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(categoryLabelAndButtonStack)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryLabelAndButtonStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            categoryLabelAndButtonStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            categoryLabelAndButtonStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            categoryLabelAndButtonStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = .clear
    }
}
