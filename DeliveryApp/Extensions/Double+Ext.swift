import Foundation

extension Double {
    func format(with: NumberFormatter.Style) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = with
        formatter.currencySymbol = "R$"
        formatter.currencyCode = "BRL"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(for: self) ?? String(self)
    }
}
