//
//  SignUpViewController.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 26/01/24.
//

import UIKit

class SignUpViewController: UIViewController {
    private var isCheked = false
    
    private lazy var customView: SignUpScreen? = {
        return view as? SignUpScreen
    }()
    
    private let viewModel: SignUpViewModelProtocol
    
    init(viewModel: SignUpViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = SignUpScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView?.setupCheckBoxDelegate(delegate: self)
        customView?.registerButton.addTarget(self, action: #selector(registerButtonTap), for: .touchUpInside)
    }
    
    @objc func registerButtonTap() {
        if let email = customView?.emailTextField.text,
           let username = customView?.userNameTextField.text,
           let password = customView?.passwordTextField.text {
            
            let userRequest = RegisterUserRequest(email: email, username: username, password: password)
            viewModel.createUserWith(userRequest: userRequest, isCheked: isCheked)
        }
    }
}

extension SignUpViewController: CheckBoxDelegate {
    func checkBoxDidChange(_ checkBox: CheckBoxButton, isChecked: Bool) {
        self.isCheked = isChecked
    }
}

extension SignUpViewController: AlertView {
    func showMessage(viewModel: AlertViewModel) {
        print(viewModel.message)
    }
}
