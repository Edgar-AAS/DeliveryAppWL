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
        hideKeyboardOnTap()
        hideNavigationBar()
        customView?.setupCheckBoxDelegate(delegate: self)
        customView?.setupTextFieldsDelegate(delegate: self)
        customView?.registerButton.addTarget(self, action: #selector(registerButtonTap), for: .touchUpInside)
        customView?.loginHereButton.addTarget(self, action: #selector(loginHereButtonTap), for: .touchUpInside)
    }
    
    
    @objc func loginHereButtonTap() {
        viewModel.routeToLogin()
    }
    
    @objc private func registerButtonTap() {
        if let email = customView?.emailTextField.text,
           let username = customView?.userNameTextField.text,
           let password = customView?.passwordTextField.text,
           let confirmPassword = customView?.passwordConfirmTextField.text
        {
            let userRequest = RegisterUserRequest(
                email: email,
                username: username,
                password: password, 
                confirmPassword: confirmPassword
            )
            viewModel.createUserWith(userRequest: userRequest, isCheked: isCheked)
        }
    }
}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField.tag {
        case 0:
            customView?.userNameTextField.becomeFirstResponder()
        case 1:
            customView?.passwordTextField.becomeFirstResponder()
        case 2:
            customView?.passwordConfirmTextField.becomeFirstResponder()
        case 3:
            customView?.passwordConfirmTextField.resignFirstResponder()
        default:
            return false
        }
        return true
    }
}

extension SignUpViewController: FieldDescriptionProtocol {
    func showMessage(viewModel: FieldDescriptionViewModel) {
        customView?.emailTextField.setDescriptionField(viewModel: viewModel)
        customView?.userNameTextField.setDescriptionField(viewModel: viewModel)
        customView?.passwordTextField.setDescriptionField(viewModel: viewModel)
        customView?.passwordConfirmTextField.setDescriptionField(viewModel: viewModel)
    }
}

extension SignUpViewController: CheckBoxDelegate {
    func checkBoxDidChange(_ checkBox: CheckBoxButton, isChecked: Bool) {
        self.isCheked = isChecked
    }
}

extension SignUpViewController: AlertView {
    func showMessage(viewModel: AlertViewModel) {}
}
