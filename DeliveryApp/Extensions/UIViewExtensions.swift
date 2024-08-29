import UIKit

extension UIView {
    private static var keyboardContext: KeyboardResponsiveContext?
    
    func setupResponsiveBehavior(scrollView: UIScrollView, referenceView: UIView) {
        UIView.keyboardContext = KeyboardResponsiveContext(scrollView: scrollView, referenceView: referenceView)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let context = UIView.keyboardContext else { return }
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height + 10, right: 0)
        context.scrollView.contentInset = contentInsets
        context.scrollView.scrollIndicatorInsets = contentInsets
        
        context.scrollView.scrollRectToVisible(context.referenceView.frame, animated: true)
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let context = UIView.keyboardContext else { return }
        
        context.scrollView.contentInset = .zero
        context.scrollView.scrollIndicatorInsets = .zero
    }
    
    func makeCornerRadius() {
        layer.cornerRadius = frame.height / 2
    }
    
    func addTouchFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: style)
        feedbackGenerator.prepare()
        feedbackGenerator.impactOccurred()
    }
    
    func makeStackView(with views: [UIView],
                       aligment: UIStackView.Alignment = .fill,
                       distribution: UIStackView.Distribution = .fill,
                       spacing: CGFloat = 0.0,
                       axis: NSLayoutConstraint.Axis) -> UIStackView {
        
        let stack = UIStackView(arrangedSubviews: views)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.alignment = aligment
        stack.distribution = distribution
        stack.spacing = spacing
        stack.axis = axis
        return stack
    }
    
    func makeButton(title: String,
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
}
