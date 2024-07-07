//
//  ResetPasswordViewController.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 06/06/24.
//

import UIKit

class ResetPasswordViewController: UIViewController {
    private lazy var customView: ResetPasswordScreen? = {
        return view as? ResetPasswordScreen
    }()
    
    override func loadView() {
        super.loadView()
        view = ResetPasswordScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

extension ResetPasswordViewController: FieldDescription {
    func showMessage(viewModel: FieldDescriptionViewModel) {
        
    }
}
