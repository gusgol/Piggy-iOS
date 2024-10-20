import Foundation
import UIKit

class MonthDate: Equatable {
    var date: Date
    
    private let calendar = Calendar.current
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter
    }
    
    init(date: Date = Date()) {
        self.date = date
    }
    
    func getFormattedDate() -> String {
        return dateFormatter.string(from: date)
    }
    
    func startOfMonth() -> Date {
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components) ?? date
    }

    func endOfMonth() -> Date {
        var components = DateComponents()
        components.month = 1
        components.day = -1
        return calendar.date(byAdding: components, to: startOfMonth() ?? date) ?? date
    }
    
    static func == (lhs: MonthDate, rhs: MonthDate) -> Bool {
        lhs.date == rhs.date
    }
}

