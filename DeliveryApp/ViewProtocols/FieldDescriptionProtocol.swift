//
//  FieldDescription.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 03/05/24.
//

import Foundation

protocol FieldDescriptionProtocol: AnyObject {
    func showMessage(viewModel: FieldDescriptionViewModel)
}

struct FieldDescriptionViewModel: Equatable {
    let message: String
    let fieldType: FieldType
}

enum FieldType: Equatable {
    case email
    case password
    case passwordConfirm
    case regular
}
