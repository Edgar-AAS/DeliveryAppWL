//
//  SignUpViewController.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 26/01/24.
//

import UIKit

class SignUpViewController: UIViewController {
    private lazy var customView: SignUpScreen? = {
        return view as? SignUpScreen
    }()

    override func loadView() {
        super.loadView()
        view = SignUpScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView?.setupCheckBoxDelegate(delegate: self)
    }
}

extension SignUpViewController: CheckBoxDelegate {
    func checkBoxDidChange(_ checkBox: CheckBoxButton, isChecked: Bool) {
        
    }
}
