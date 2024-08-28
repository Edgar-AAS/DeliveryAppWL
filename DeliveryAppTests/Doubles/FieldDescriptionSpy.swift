//
//  FieldDescriptionSpy.swift
//  DeliveryAppTests
//
//  Created by Edgar Arlindo on 16/07/24.
//

import Foundation
@testable import DeliveryApp

class FieldDescriptionSpy: FieldValidationDelegate {
    private(set) var emit: ((FieldValidationViewModel) -> Void)?
    
    func observe(completion: @escaping (FieldValidationViewModel) -> Void) {
        self.emit = completion
    }

    func showMessage(viewModel: DeliveryApp.FieldValidationViewModel) {
        self.emit?(viewModel)
    }
}
