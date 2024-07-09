//
//  FoodDetailsViewController.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 08/07/24.
//

import UIKit

class FoodDetailsViewController: UIViewController {
    private lazy var customView: FoodDetailsScreen? = {
        return view as? FoodDetailsScreen
    }()
    
    override func loadView() {
        super.loadView()
        view = FoodDetailsScreen()
    }
    
    private let viewModel: FoodDetailsViewModel
    
    init(viewModel: FoodDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideNavigationBar()
        customView?.delegate = self
    }
}

extension FoodDetailsViewController: FoodDetailsScreenDelegate {
    func backButtonDidTapped() {
        navigationController?.popViewController(animated: true)
    }
}
