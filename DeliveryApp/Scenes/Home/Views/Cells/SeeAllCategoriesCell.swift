import UIKit



protocol SeeAllCategoriesCellDelegate: AnyObject {
    func seeAllButtonDidTapped(_ cell: SeeAllCategoriesCell)
}

class SeeAllCategoriesCell: UITableViewCell {
    static let reuseIdentifier = String(describing: SeeAllCategoriesCell.self)
    
    weak var delegate: SeeAllCategoriesCellDelegate?
    
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
    
    private lazy var seeAllButton = makeTitleButton(
        title: "See All",
        titleColor: Colors.primary,
        font:  Fonts.bold(size: 14).weight,
        action: UIAction { [weak self] _ in
            guard let self else { return }
            self.delegate?.seeAllButtonDidTapped(self)
        }
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
