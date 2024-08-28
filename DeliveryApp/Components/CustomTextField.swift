import UIKit


enum FieldType: Equatable {
    case email
    case password
    case passwordConfirm
    case regular
}

final class CustomTextField: UITextField {
    private let exampleText: String
    private let fieldType: FieldType?
    private let fieldTag: Int
    private let returnType: UIReturnKeyType
    private weak var fieldDelegate: UITextFieldDelegate?
    
    private var padding: CGFloat = 20.0
    
    private var isHide: Bool = true {
        didSet {
            eyeButton.isSelected = !isHide
            isSecureTextEntry = isHide
        }
    }
    
    init(placeholder: String,
         fieldType: FieldType = .regular,
         tag: Int = 0,
         returnKeyType: UIReturnKeyType = .default,
         delegate: UITextFieldDelegate? = nil
    )
    {
        self.exampleText = placeholder
        self.fieldType = fieldType
        self.fieldTag = tag
        self.returnType = returnKeyType
        self.fieldDelegate = delegate
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    private func setup() {
        tag = fieldTag
        delegate = fieldDelegate
        returnKeyType = returnType
        backgroundColor = .white
        tintColor = .black
        textColor = .black
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = Colors.grayBorderColor.cgColor
        placeholder = exampleText
        addSubview(feedbackLabel)
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: attributes)
        self.attributedPlaceholder = attributedPlaceholder
    
        if let fieldType = fieldType {
            if fieldType == .email {
                keyboardType = .emailAddress
                autocapitalizationType = .none
                autocorrectionType = .no
            } else if fieldType == .password || fieldType == .passwordConfirm{
                isSecureTextEntry = true
                showEyeButton()
            }
        }
        
        NSLayoutConstraint.activate([
            feedbackLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 4),
            feedbackLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            feedbackLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func showEyeButton() {
        padding = 48.0
        let frame = CGRect(x: 0, y: 0, width: eyeButton.frame.size.width + 10, height: eyeButton.frame.size.height)
        let outerView = UIView(frame: frame)
        outerView.addSubview(eyeButton)
        rightViewMode = .always
        rightView = outerView
    }
    
    private lazy var feedbackLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .red
        label.isHidden = true
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()
        
    private lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.frame.size = .init(width: 24, height: 24)
        button.tintColor = .black
    
        let action = UIAction { [weak self] _ in
            self?.eyeButtonTap()
        }
        
        button.addAction(action, for: .touchUpInside)
        return button
    }()

    private func eyeButtonTap() {
        addTouchFeedback(style: .rigid)
        isHide = !isHide
    }
    
    func setDescriptionField(viewModel: FieldValidationViewModel) {
        if fieldType != viewModel.type {
            feedbackLabel.isHidden = true
            return
        }
        
        feedbackLabel.isHidden = false
        feedbackLabel.text = viewModel.message
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: 10, y: 0, width: bounds.width - padding, height: bounds.height)
        return bounds
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: 10, y: 0, width: bounds.width - padding, height: bounds.height)
        return bounds
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let bounds = CGRect(x: 10, y: 0, width: bounds.width - padding, height: bounds.height)
        return bounds
    }
}
