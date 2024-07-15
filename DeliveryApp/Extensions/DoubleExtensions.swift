//
//  DoubleExtensions.swift
//  DeliveryApp
//
//  Created by Edgar Arlindo on 11/07/24.
//

import Foundation

extension Double {
    func currencyFormatWith(numberStyle: NumberFormatter.Style) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = numberStyle
        formatter.currencySymbol = "R$"
        formatter.currencyCode = "BRL"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(for: self) ?? String(self)
    }
}
