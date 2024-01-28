//
//  UIViewExtensions.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 26/01/24.
//

import UIKit

extension UIView {
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
    
    func makeSeparatorView(height: CGFloat = 1, color: UIColor = .black) -> UIView {
        let separatorView = UIView()
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = color
        separatorView.heightAnchor.constraint(equalToConstant: height).isActive = true
        return separatorView
    }
    
    func makeButtonStack(buttons: [UIButton]) -> UIStackView {
        let stack = makeStackView(with: buttons,
                             aligment: .center,
                             distribution: .equalSpacing,
                             spacing: 16,
                             axis: .horizontal)

        stack.frame.size = .init(width: buttons.last?.frame.width ?? 0,
                                 height: buttons.last?.frame.height ?? 0)
        return stack
    }
}
