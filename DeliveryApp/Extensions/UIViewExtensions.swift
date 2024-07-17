//
//  UIViewExtensions.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 26/01/24.
//

import UIKit

extension UIView {
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
    
    func makeSeparatorView(height: CGFloat = 0.5, color: UIColor = .black) -> UIView {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = color
        separatorView.heightAnchor.constraint(equalToConstant: height).isActive = true
        return separatorView
    }
}
