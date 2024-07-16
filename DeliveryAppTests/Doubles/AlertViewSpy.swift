//
//  AlertViewSpy.swift
//  DeliveryAppTests
//
//  Created by Edgar Arlindo on 16/07/24.
//

import Foundation
@testable import DeliveryApp

class AlertViewSpy: AlertView {
    var emit: ((AlertViewModel) -> Void)?
    
    func observe(completion: @escaping (AlertViewModel) -> Void) {
        self.emit = completion
    }

    func showMessage(viewModel: AlertViewModel) {
        self.emit?(viewModel)
    }
}
