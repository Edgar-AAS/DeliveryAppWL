import UIKit

final class CustomTextField: UITextField {
    private let exampleText: String
    private let fieldType: String
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
         fieldType: String = "",
         tag: Int = 0,
         returnKeyType: UIReturnKeyType = .default,
         delegate: UITextFieldDelegate? = nil
    ) {
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
        delegate = self
        returnKeyType = returnType
        backgroundColor = .white
        tintColor = .black
        textColor = .black
        layer.cornerRadius = 8
        layer.borderWidth = 2
        textContentType = .none
        layer.borderColor = Colors.grayBorder.cgColor
        placeholder = exampleText
        addSubview(feedbackLabel)
        
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray]
        let attributedPlaceholder = NSAttributedString(string: self.placeholder ?? "", attributes: attributes)
        self.attributedPlaceholder = attributedPlaceholder
    
        switch fieldType {
        case "email":
            keyboardType = .emailAddress
            autocapitalizationType = .none
            autocorrectionType = .no
        case "password", "passwordConfirm":
            isSecureTextEntry = true
            autocorrectionType = .no
            showEyeButton()
        case "phone":
            keyboardType = .numberPad
        default:
            break
        }
        
        NSLayoutConstraint.activate([
            feedbackLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 4),
            feedbackLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
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
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        return label
    }()
    
    private lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: SFSymbols.closeEye), for: .normal)
        button.setImage(UIImage(systemName: SFSymbols.openEye), for: .selected)
        button.frame.size = .init(width: 24, height: 24)
        button.tintColor = .black
        
        let action = UIAction { [weak self] _ in
            self?.eyeButtonTap()
        }
        
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private func eyeButtonTap() {
        addTouchFeedback(style: .light)
        isHide = !isHide
    }
    
    func clearFeddback() {
        feedbackLabel.text = ""
    }
    
    func hidePassword() {
        isHide = true
    }
    
    func setDescriptionField(with model: ValidationFieldModel) {
        if fieldType != model.fieldType {
            feedbackLabel.isHidden = true
            return
        }
        
        feedbackLabel.isHidden = false
        feedbackLabel.text = model.message
    }
    
    func resetField() {
        text = ""
        feedbackLabel.text = ""
        layer.borderColor = Colors.grayBorder.cgColor
        
        if fieldType == "password" || fieldType == "passwordConfirm" {
            isHide = true
        }
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

extension CustomTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fieldType = fieldType
        
        switch fieldType {
        case "phone":
            guard let currentText = textField.text as NSString? else { return false }
            let newString = currentText.replacingCharacters(in: range, with: string)
            
            let cleanPhoneNumber = newString.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            let mask = "(##) #####-####"
            var formattedString = ""
            var index = cleanPhoneNumber.startIndex
            
            for ch in mask where index < cleanPhoneNumber.endIndex {
                if ch == "#" {
                    formattedString.append(cleanPhoneNumber[index])
                    index = cleanPhoneNumber.index(after: index)
                } else {
                    formattedString.append(ch)
                }
            }
            
            textField.text = formattedString
            return false
        default:
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        layer.borderColor = Colors.primary.cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        layer.borderColor = Colors.grayBorder.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return fieldDelegate?.textFieldShouldReturn?(textField) ?? true
    }
}
