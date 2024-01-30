//
//  AlertView.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/01/24.
//

import Foundation

public protocol AlertView: AnyObject {
    func showMessage(viewModel: AlertViewModel)
}

public struct AlertViewModel: Model {
    public let title: String
    public let message: String
    
    public init(title: String, message: String) {
        self.title = title
        self.message = message
    }
}
