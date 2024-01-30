//
//  EmailValidator.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 29/01/24.
//

import Foundation

protocol EmailValidator {
    func isValid(email: String) -> Bool
}

final class EmailValidatorAdapter: EmailValidator {
    private let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    public init() {}
    
    func isValid(email: String) -> Bool {
        let range = NSRange(location: 0, length: email.utf16.count)
        let regex = try! NSRegularExpression(pattern: emailRegex)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
}
