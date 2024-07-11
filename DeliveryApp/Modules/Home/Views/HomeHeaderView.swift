//
//  HomeView.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 24/04/24.
//

import UIKit

class HomeHeaderView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var headerImageView: UIImageView = {
        let image = UIImage(named: "header_background")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Location"
        label.font = UIFont(name: "Inter-Regular", size: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var changeLocationButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.setImage(UIImage(named: "arrow_down"), for: .normal)
        return button
    }()
    
    private lazy var locationIcon: UIImageView = {
        let image = UIImage(named: "location-pin")
        let imageView = UIImageView(image: image)
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        return UIImageView(image: image)
    }()
    
    private lazy var adressLabel: UILabel = {
        let label = UILabel()
        label.text = "Rua dos camões, 204"
        label.font = UIFont(name: "Inter-SemiBold", size: 14)
        label.textColor = .white
        return label
    }()
    
    private lazy var searchButton: UIButton =  {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "search-icon"), for: .normal)
        button.tintColor = .white
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private lazy var notificationButton: UIButton =  {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "notification-icon"), for: .normal)
        button.tintColor = .white
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        return button
    }()
    
    private lazy var descriptionHomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Provide the best food for you"
        label.font = UIFont(name: "Inter-SemiBold", size: 32)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .white
        return label
    }()
    
    private lazy var locationStack = makeStackView(with: [locationLabel, changeLocationButton],
                                                   spacing: 8,
                                                   axis: .horizontal)
    
    private lazy var adressStack = makeStackView(with: [locationIcon, adressLabel],
                                                 spacing: 8,
                                                 axis: .horizontal)
    
    private lazy var circularButtonStack = makeStackView(with: [searchButton, notificationButton],
                                                         spacing: 16,
                                                         axis: .horizontal)

}

extension HomeHeaderView: CodeView {
    func buildViewHierarchy() {
        addSubview(headerImageView)
        headerImageView.addSubview(locationStack)
        headerImageView.addSubview(adressStack)
        headerImageView.addSubview(searchButton)
        headerImageView.addSubview(circularButtonStack)
        headerImageView.addSubview(descriptionHomeLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: topAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            locationStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            locationStack.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor, constant: 24),
            
            adressStack.topAnchor.constraint(equalTo: locationStack.bottomAnchor, constant: 12),
            adressStack.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor, constant: 24),
            adressStack.trailingAnchor.constraint(lessThanOrEqualTo: circularButtonStack.leadingAnchor, constant: -10),
            
            circularButtonStack.topAnchor.constraint(equalTo: locationStack.topAnchor),
            circularButtonStack.trailingAnchor.constraint(equalTo: headerImageView.trailingAnchor, constant: -24),
            
            descriptionHomeLabel.topAnchor.constraint(equalTo: adressStack.bottomAnchor, constant: 24),
            descriptionHomeLabel.leadingAnchor.constraint(equalTo: headerImageView.leadingAnchor, constant: 24),
            descriptionHomeLabel.trailingAnchor.constraint(equalTo: headerImageView.trailingAnchor, constant: -24),
            descriptionHomeLabel.bottomAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: -10)
        ])
    }
    
    func setupAddiotionalConfiguration() {
        backgroundColor = .white
    }
}
