//
//  MyCartScreen.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 20/08/24.
//

import UIKit

class MyCartScreen: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = Colors.backgroundColor
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var myCartTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Fonts.medium(size: 14).weight
        label.textColor = .black
        return label
    }()
}

extension MyCartScreen: CodeView {
    func buildViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
}
