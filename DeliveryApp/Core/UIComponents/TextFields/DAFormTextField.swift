import UIKit

final class DAFormTextField: UITextField {
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
         delegate: UITextFieldDelegate? = nil)
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
        case "date":
            inputView = datePicker
            setupToolBar()
        case "phone":
            placeholder = "(__)____-____"
            setupToolBar()
            keyboardType = .phonePad
        default:
            break
        }
        
        NSLayoutConstraint.activate([
            feedbackLabel.topAnchor.constraint(equalTo: bottomAnchor, constant: 4),
            feedbackLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            feedbackLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private  func setupToolBar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneTapped))
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([space, doneButton], animated: false)
        self.inputAccessoryView = toolbar
    }
    
    @objc private func doneTapped() {
        if fieldType == "date" {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            text = formatter.string(from: datePicker.date)
        }
        resignFirstResponder()
    }
    
    private lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.locale = Locale(identifier: "pt_BR")
        picker.preferredDatePickerStyle = .wheels
        picker.maximumDate = Date()
        return picker
    }()
            
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
    
    func hidePassword() {
        isHide = true
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

extension DAFormTextField: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        layer.borderColor = UIColor(resource: .primary1).cgColor
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        layer.borderColor = Colors.grayBorder.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return fieldDelegate?.textFieldShouldReturn?(textField) ?? true
    }
}
