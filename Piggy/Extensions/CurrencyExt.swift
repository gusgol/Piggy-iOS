import Foundation

extension Int {
    func toFormattedAmount(locale: Locale = .current) -> String? {
        let amountInDollars = Double(self) / 100.0
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = locale
        return formatter.string(from: NSNumber(value: amountInDollars))
    }
}

class CurrencyFormatter: NumberFormatter {
    override init() {
        super.init()
        self.numberStyle = .currency
        self.currencySymbol = ""
        self.maximumFractionDigits = 2
        self.minimumFractionDigits = 2
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
