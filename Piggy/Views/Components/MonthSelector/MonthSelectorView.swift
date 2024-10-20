import SwiftUI

struct MonthSelectorView: View {
    @Binding var currentDate: MonthDate
    
    private let calendar = Calendar.current

    var body: some View {
        HStack {
            Button(action: previousMonth) {
                Image(systemName: "chevron.left")
            }
            Spacer()
            HStack {
                Image(systemName: "calendar")
                Text(currentDate.getFormattedDate())
            }
            Spacer()
            Button(action: nextMonth) {
                Image(systemName: "chevron.right")
            }
        }
        .padding()
    }
    
    private func previousMonth() {
        if let newDate = calendar.date(byAdding: .month, value: -1, to: currentDate.date) {
            currentDate = MonthDate(date: newDate)
        }
    }
    
    private func nextMonth() {
        if let newDate = calendar.date(byAdding: .month, value: 1, to: currentDate.date) {
            currentDate = MonthDate(date: newDate)
        }
    }
}
