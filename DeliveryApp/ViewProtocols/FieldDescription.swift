//
//  FieldDescription.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 03/05/24.
//

import Foundation

protocol FieldDescription: AnyObject {
    func showMessage(viewModel: FieldDescriptionViewModel)
}

struct FieldDescriptionViewModel {
    let message: String
    let fieldType: FieldType
}

enum FieldType {
    case email
    case password
    case passwordConfirm
    case regular
}
