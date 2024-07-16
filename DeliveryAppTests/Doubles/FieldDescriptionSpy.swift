//
//  FieldDescriptionSpy.swift
//  DeliveryAppTests
//
//  Created by Edgar Arlindo on 16/07/24.
//

import Foundation
@testable import DeliveryApp

class FieldDescriptionSpy: FieldDescriptionProtocol {
    private(set) var emit: ((FieldDescriptionViewModel) -> Void)?
    
    func observe(completion: @escaping (FieldDescriptionViewModel) -> Void) {
        self.emit = completion
    }

    func showMessage(viewModel: DeliveryApp.FieldDescriptionViewModel) {
        self.emit?(viewModel)
    }
}
