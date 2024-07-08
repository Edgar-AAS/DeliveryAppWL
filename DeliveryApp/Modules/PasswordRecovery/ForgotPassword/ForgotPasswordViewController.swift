//
//  ForgotPasswordViewController.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 19/05/24.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    private lazy var customView: ForgotPasswordScreen? = {
        return view as? ForgotPasswordScreen
    }()
    
    private let viewModel: ForgotPasswordViewModelProtocol
    
    override func loadView() {
        super.loadView()
        view = ForgotPasswordScreen(delegate: self)
    }
    
    init(viewModel: ForgotPasswordViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ForgotPasswordViewController: ForgotPasswordScreenDelegateProtocol {
    func continueButtonDidTapped() {
        if let email = customView?.emailTextField.text {
            let userRequest = ForgotPasswordUserRequest(email: email)
            viewModel.sendPasswordReset(with: userRequest)
        }
    }
}
