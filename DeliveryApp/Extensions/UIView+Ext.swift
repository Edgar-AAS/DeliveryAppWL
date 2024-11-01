import UIKit

struct KeyboardResponsiveContext {
    var scrollView: UIScrollView
}

extension UIView {
    private static var keyboardContext: KeyboardResponsiveContext?
    
    func setupKeyboardHandling(scrollView: UIScrollView) {
        UIView.keyboardContext = KeyboardResponsiveContext(scrollView: scrollView)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let scrollView = UIView.keyboardContext?.scrollView else {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height + 10, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        var aRect = frame
        aRect.size.height -= keyboardSize.height
        
        if let activeField = firstResponder as? UITextField {
            let frameInContentView = activeField.convert(activeField.bounds, to: scrollView)
            if !aRect.contains(frameInContentView.origin) {
                scrollView.scrollRectToVisible(frameInContentView, animated: true)
            }
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let scrollView = UIView.keyboardContext?.scrollView else {
            return
        }
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    private var firstResponder: UIView? {
        guard !isFirstResponder else { return self }
        
        for subview in subviews {
            if let firstResponder = subview.firstResponder {
                return firstResponder
            }
        }
        
        return nil
    }
    
    func addTouchFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }
    
    func makeStackView(with views: [UIView],
                       aligment: UIStackView.Alignment = .fill,
                       distribution: UIStackView.Distribution = .fill,
                       spacing: CGFloat = 8.0,
                       axis: NSLayoutConstraint.Axis) -> UIStackView {
        
        let stack = UIStackView(arrangedSubviews: views)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = aligment
        stack.distribution = distribution
        stack.spacing = spacing
        stack.axis = axis
        return stack
    }
    
    func makeTitleButton(title: String? = "",
                         titleColor: UIColor,
                         font: UIFont,
                         backgroundColor: UIColor? = nil,
                         action: UIAction? = nil) -> UIButton {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.titleLabel?.font = font
        button.backgroundColor = backgroundColor
        
        if let action = action {
            button.addAction(action, for: .touchUpInside)
        }
        return button
    }
    
    func makeIconButton(icon: UIImage, backgroundColor: UIColor? = nil, action: UIAction) -> UIButton {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = backgroundColor
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(icon, for: .normal)
        button.addAction(action, for: .touchUpInside)
        return button
    }
    
    func makeImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
    
    func makeLabel(text: String? = nil,
                   font: UIFont = .systemFont(ofSize: 12),
                   color: UIColor = .black,
                   textAlignment: NSTextAlignment = .natural,
                   numberOfLines: Int = 1) -> UILabel {
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.font = font
        label.textColor = color
        label.textAlignment = textAlignment
        label.numberOfLines = numberOfLines
        return label
    }
    
    func makeSeparatorView(height: CGFloat = 0.5, color: UIColor = .black) -> UIView {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = color
        separatorView.heightAnchor.constraint(equalToConstant: height).isActive = true
        return separatorView
    }
    
    func hideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        endEditing(true)
    }
}
