//
//  LoginViewController.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 25/01/24.
//

import UIKit

class LoginViewController: UIViewController {
    private lazy var customView: LoginScreen? = {
        return view as? LoginScreen
    }()
    
    override func loadView() {
        super.loadView()
        view = LoginScreen()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView?.registerButton.addTarget(self, action: #selector(buttonTap), for: .touchUpInside)
    }
    
    @objc func buttonTap() {
        
    }
}
